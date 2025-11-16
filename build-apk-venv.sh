#!/bin/bash
# Script to build APK in isolated environment with Android SDK
# This script sets up Android SDK and builds the Termux Crush App APK

echo "Building Termux Crush App APK in isolated environment"
echo "==================================================="

# Create build directory
BUILD_DIR="$HOME/termux-crush-build-venv"
echo "Creating build directory: $BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Set up Android SDK in isolated environment
echo "Setting up Android SDK..."
SDK_DIR="$BUILD_DIR/android-sdk"
mkdir -p "$SDK_DIR"
cd "$SDK_DIR"

# Download Android command line tools
if [ ! -f "commandlinetools-linux.zip" ]; then
    echo "Downloading Android command line tools..."
    wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O commandlinetools-linux.zip
fi

# Extract tools
echo "Extracting command line tools..."
mkdir -p cmdline-tools
unzip -q commandlinetools-linux.zip -d cmdline-tools/
mv cmdline-tools/cmdline-tools cmdline-tools/latest

# Set up environment variables for this session
export ANDROID_HOME="$SDK_DIR"
export ANDROID_SDK_ROOT="$SDK_DIR"
export PATH="$SDK_DIR/cmdline-tools/latest/bin:$SDK_DIR/platform-tools:$SDK_DIR/build-tools:$PATH"

echo "Android SDK environment set up:"
echo "  ANDROID_HOME: $ANDROID_HOME"

# Accept licenses
echo "Accepting Android SDK licenses..."
echo y | cmdline-tools/latest/bin/sdkmanager --licenses >/dev/null 2>&1

# Install essential SDK components
echo "Installing essential SDK components..."
cmdline-tools/latest/bin/sdkmanager --install "platform-tools" "platforms;android-30" "build-tools;30.0.3" >/dev/null

echo "Android SDK setup completed!"

# Go back to build directory
cd "$BUILD_DIR"

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

# Check if Docker is available for package building
if command -v docker &> /dev/null; then
    echo "Docker found, building packages..."
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
exit
EOF_DOCKER
else
    echo "Docker not found. Please install Docker to build packages."
    echo "Falling back to using pre-built bootstrap (if available)..."
    # If we have pre-built bootstrap files, we can use them
    # Otherwise, we'll need to skip this step
fi

# Copy bootstrap files to termux-app if they exist
if ls bootstrap-*.zip 1> /dev/null 2>&1; then
    echo "Copying bootstrap files..."
    cp bootstrap-*.zip ../termux-app/app/src/main/cpp/
else
    echo "No bootstrap files found. Building without pre-installed packages."
    echo "The app will need to download packages on first run."
fi

# Modify termux-app for our package
cd ../termux-app

# Update package name in build.gradle
echo "Updating package name in build.gradle..."
sed -i 's/com\.termux/com.termux.crush/g' app/build.gradle

# Comment out downloadBootstrap task
echo "Modifying build.gradle to skip official bootstrap download..."
sed -i '/task downloadBootstraps/,/}/s/^/\/\//g' app/build.gradle

# Build APK using Gradle
echo "Building APK with isolated Android SDK..."
if [ -f "gradlew" ]; then
    chmod +x gradlew
    # Use the isolated Android SDK
    env ANDROID_HOME="$ANDROID_HOME" ./gradlew assembleRelease
else
    echo "gradlew not found. Trying with system gradle..."
    env ANDROID_HOME="$ANDROID_HOME" gradle assembleRelease
fi

# Check if APK was built successfully
APK_PATH="app/build/outputs/apk/release/app-release-unsigned.apk"
if [ -f "$APK_PATH" ]; then
    echo "APK built successfully!"
    echo "Copying APK to project directory..."
    cp "$APK_PATH" "$OLDPWD/termux-crush-app-venv-built.apk"
    echo "APK saved as: $OLDPWD/termux-crush-app-venv-built.apk"
    
    # Also copy to a more standard name
    cp "$APK_PATH" "$OLDPWD/termux-crush-app.apk"
    echo "APK also saved as: $OLDPWD/termux-crush-app.apk"
else
    echo "APK build failed. Check the build logs above for errors."
    echo "The app might still be usable but without pre-installed packages."
    
    # Try to find any APK that was built
    if ls app/build/outputs/apk/*/*.apk 1> /dev/null 2>&1; then
        FOUND_APK=$(ls app/build/outputs/apk/*/*.apk | head -1)
        echo "Found APK at: $FOUND_APK"
        cp "$FOUND_APK" "$OLDPWD/termux-crush-app-fallback.apk"
        echo "Fallback APK saved as: $OLDPWD/termux-crush-app-fallback.apk"
    fi
    
    exit 1
fi

echo ""
echo "Build process completed in isolated environment!"
echo "=============================================="
echo "The APK has been built and saved as termux-crush-app.apk"
echo "To install on an Android device:"
echo "1. Transfer the APK to your device"
echo "2. Enable 'Install unknown apps' in Settings"
echo "3. Tap on the APK file to install"
echo ""
echo "Note: This is an unsigned APK. For production use, you should sign it with your own key."