#!/bin/bash
# Script to set up Android SDK in an isolated environment
# This script downloads and configures Android SDK for building APKs

echo "Setting up Android SDK in isolated environment"
echo "============================================"

# Create isolated environment directory
SDK_DIR="$HOME/android-sdk-isolated"
echo "Creating isolated SDK directory: $SDK_DIR"
mkdir -p "$SDK_DIR"
cd "$SDK_DIR"

# Download Android command line tools
echo "Downloading Android command line tools..."
if [ ! -f "commandlinetools-linux.zip" ]; then
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
echo "  SDK Tools: $SDK_DIR/cmdline-tools/latest"

# Accept licenses
echo "Accepting Android SDK licenses..."
yes | cmdline-tools/latest/bin/sdkmanager --licenses

# Install essential SDK components
echo "Installing essential SDK components..."
cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3"

echo "Android SDK setup completed!"
echo ""
echo "To use this SDK for building APKs:"
echo "1. Export these environment variables:"
echo "   export ANDROID_HOME=$ANDROID_HOME"
echo "   export ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT"
echo "   export PATH=$PATH"
echo ""
echo "2. Or source this script in your build environment"
echo ""
echo "The SDK is now ready for building Android APKs!"