#!/bin/bash
# Script to set up Android environment and build the Termux Crush App APK
# This script downloads the necessary tools and builds the APK

echo "Setting up Android environment and building Termux Crush App APK"
echo "=============================================================="

# Check if we're on Windows (WSL) or Linux/Mac
if [[ -n "$WINDIR" ]] || [[ -n "$windir" ]]; then
    PLATFORM="windows"
    echo "Detected Windows platform"
elif [[ "$(uname)" == "Darwin" ]]; then
    PLATFORM="mac"
    echo "Detected macOS platform"
else
    PLATFORM="linux"
    echo "Detected Linux platform"
fi

# Create build directory
BUILD_DIR="$HOME/termux-crush-build"
echo "Creating build directory: $BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Check if Android Studio/SDK is already installed
if [ -d "$ANDROID_HOME" ] || [ -d "$ANDROID_SDK_ROOT" ]; then
    echo "Android SDK found"
else
    echo "Android SDK not found, setting up..."
    
    # For Linux, we can download SDK tools
    if [ "$PLATFORM" = "linux" ]; then
        # Download Android command line tools
        if [ ! -f "commandlinetools-linux.zip" ]; then
            echo "Downloading Android command line tools..."
            wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O commandlinetools-linux.zip
        fi
        
        # Extract tools
        mkdir -p android-sdk/cmdline-tools
        unzip -q commandlinetools-linux.zip -d android-sdk/cmdline-tools/
        mv android-sdk/cmdline-tools/cmdline-tools android-sdk/cmdline-tools/latest
        
        # Set environment variables
        export ANDROID_HOME="$BUILD_DIR/android-sdk"
        export ANDROID_SDK_ROOT="$ANDROID_HOME"
        export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"
        
        echo "Android SDK installed to $ANDROID_HOME"
    else
        echo "Please install Android Studio or Android SDK for $PLATFORM"
        echo "Download from: https://developer.android.com/studio"
        exit 1
    fi
fi

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker to build packages."
    echo "Download from: https://www.docker.com/products/docker-desktop"
    exit 1
fi

# Clone repositories if they don't exist
echo "Cloning repositories..."
if [ ! -d "termux-app" ]; then
    git clone https://github.com/termux/termux-app
else
    echo "termux-app already exists, pulling latest changes..."
    cd termux-app && git pull && cd ..
fi

if [ ! -d "termux-packages" ]; then
    git clone https://github.com/termux/termux-packages
else
    echo "termux-packages already exists, pulling latest changes..."
    cd termux-packages && git pull && cd ..
fi

# Copy our custom package
echo "Setting up custom Crush package..."
cp -r "$OLDPWD/crush-package" termux-packages/packages/crush

# Prepare build environment
cd termux-packages

# Download build-bootstrap.sh if it doesn't exist
if [ ! -f "scripts/build-bootstrap.sh" ]; then
    echo "Downloading build-bootstrap.sh script..."
    wget https://gist.github.com/seeya/a9ce074cf560aa7113043859360b7bfc/raw/206b5f4755b65569cf4af8d92b2481258c134b74/build-bootstrap.sh -O scripts/build-bootstrap.sh
    chmod +x scripts/build-bootstrap.sh
fi

# Update properties.sh
echo "Updating properties.sh..."
sed -i 's/TERMUX_APP_PACKAGE=.*/TERMUX_APP_PACKAGE="com.termux.crush"/' scripts/properties.sh

# Build packages using Docker
echo "Building packages with Docker..."
./scripts/run-docker.sh << 'EOF_DOCKER'
echo "Inside Docker container, building packages..."
./build-package.sh -a aarch64 git
./build-package.sh -a aarch64 golang
./build-package.sh -a aarch64 vim
./build-package.sh -a aarch64 neovim
./build-package.sh -a aarch64 crush
echo "Creating bootstrap..."
./scripts/build-bootstrap.sh --architectures aarch64,arm,i686,x86_64
EOF_DOCKER

# Copy bootstrap files to termux-app
echo "Copying bootstrap files..."
cp bootstrap-*.zip ../termux-app/app/src/main/cpp/

# Modify termux-app for our package
cd ../termux-app

# Update package name in build.gradle
echo "Updating package name in build.gradle..."
sed -i 's/com\.termux/com.termux.crush/g' app/build.gradle

# Comment out downloadBootstrap task
echo "Modifying build.gradle to skip official bootstrap download..."
sed -i '/task downloadBootstraps/,/}/s/^/\/\//g' app/build.gradle

# Build APK using Gradle
echo "Building APK..."
if [ -f "gradlew" ]; then
    chmod +x gradlew
    ./gradlew assembleRelease
else
    echo "gradlew not found, trying with system gradle..."
    gradle assembleRelease
fi

# Check if APK was built successfully
if [ -f "app/build/outputs/apk/release/app-release-unsigned.apk" ]; then
    echo "APK built successfully!"
    echo "Copying APK to project directory..."
    cp "app/build/outputs/apk/release/app-release-unsigned.apk" "$OLDPWD/termux-crush-app-built.apk"
    echo "APK saved as: $OLDPWD/termux-crush-app-built.apk"
else
    echo "APK build failed. Check the build logs above for errors."
    exit 1
fi

echo ""
echo "Build process completed!"
echo "======================"
echo "The APK has been built and saved as termux-crush-app-built.apk"
echo "To install on an Android device:"
echo "1. Transfer the APK to your device"
echo "2. Enable 'Install unknown apps' in Settings"
echo "3. Tap on the APK file to install"
echo ""
echo "Note: This is an unsigned APK. For production use, you should sign it with your own key."