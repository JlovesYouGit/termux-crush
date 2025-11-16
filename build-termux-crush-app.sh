#!/bin/bash

# Script to build custom Termux app with Crush pre-installed
# This script provides guidance and automation for building the custom APK

echo "Building Termux Crush App"
echo "========================"

# Check if required tools are installed
echo "Checking prerequisites..."

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

# Clone repositories
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

echo "Setup complete!"
echo ""
echo "Next steps:"
echo "1. cd termux-packages"
echo "2. ./scripts/run-docker.sh"
echo "3. Inside Docker container:"
echo "   - ./build-package.sh -a aarch64 git"
echo "   - ./build-package.sh -a aarch64 golang"
echo "   - ./build-package.sh -a aarch64 vim"
echo "   - ./build-package.sh -a aarch64 crush"
echo "   - ./scripts/build-bootstrap.sh --architectures aarch64,arm,i686,x86_64"
echo "4. Copy bootstrap files to termux-app/app/src/main/cpp/"
echo "5. Build APK in Android Studio"

echo ""
echo "For detailed instructions, see BUILD_INSTRUCTIONS.md"