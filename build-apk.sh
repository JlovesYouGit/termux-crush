#!/bin/bash
# Script to build the Termux Crush App APK
# This script automates the build process as much as possible

echo "Building Termux Crush App APK"
echo "============================="

# Check prerequisites
echo "Checking prerequisites..."

# Check if required tools are installed
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed"
    exit 1
fi

if ! command -v docker &> /dev/null; then
    echo "Error: docker is not installed"
    exit 1
fi

echo "All prerequisites found."

# Create working directory
WORK_DIR="$HOME/termux-crush-build"
echo "Creating working directory: $WORK_DIR"
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

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

echo "Setting up custom package..."
# Copy crush package definition
cp -r ../crush-package termux-packages/packages/crush

# Copy test suite for validation
cp -r ../scripts/test-suite.sh termux-packages/packages/crush/

echo "Preparing build environment..."
cd termux-packages

# Download build-bootstrap.sh script if it doesn't exist
if [ ! -f "scripts/build-bootstrap.sh" ]; then
    echo "Downloading build-bootstrap.sh script..."
    wget https://gist.github.com/seeya/a9ce074cf560aa7113043859360b7bfc/raw/206b5f4755b65569cf4af8d92b2481258c134b74/build-bootstrap.sh -O scripts/build-bootstrap.sh
    chmod +x scripts/build-bootstrap.sh
fi

# Edit properties.sh to set TERMUX_APP_PACKAGE
echo "Updating properties.sh..."
sed -i 's/TERMUX_APP_PACKAGE=.*/TERMUX_APP_PACKAGE="com.termux.crush"/' scripts/properties.sh

echo "Building required packages..."
# Start Docker container and build packages
echo "Starting Docker container..."
./scripts/run-docker.sh << 'EOF'
# Inside Docker container
echo "Building packages..."
./build-package.sh -a aarch64 git
./build-package.sh -a aarch64 golang
./build-package.sh -a aarch64 vim
./build-package.sh -a aarch64 neovim
./build-package.sh -a aarch64 crush

echo "Creating custom bootstrap..."
./scripts/build-bootstrap.sh --architectures aarch64,arm,i686,x86_64
EOF

echo "Integrating bootstrap with app..."
cd ../termux-app
# Copy the generated bootstrap ZIP files
cp ../termux-packages/bootstrap-*.zip app/src/main/cpp/

# Modify app/build.gradle to skip downloading official bootstrap
# This would need to be done manually in the actual file
echo "NOTE: You need to manually modify app/build.gradle to skip downloading official bootstrap"
echo "Comment out or modify the downloadBootstraps task in app/build.gradle"

echo ""
echo "Next steps:"
echo "1. Open the termux-app project in Android Studio"
echo "2. Clean and build the project"
echo "3. Generate signed APK"
echo "4. The APK will be located in app/build/outputs/apk/"

echo ""
echo "For detailed instructions, see BUILD_INSTRUCTIONS.md"