# Termux Crush App v1.0.0 Release

## Status
⚠️ **Pre-release**: This release is a pre-release. The APK file will be built and added to this directory.

## Overview
This release includes the Termux Crush App with a comprehensive testing framework. The app is a custom Android application that bundles Termux with Crush CLI pre-installed for easy deployment on Android devices.

## Features
- Termux environment with all necessary dependencies pre-installed
- Crush CLI ready to use out of the box
- Integrated Vim/Neovim editor for easy code editing
- No conflicts with existing Termux installations
- Easy debugging and management tools
- Comprehensive APK testing framework

## What's Included
This release directory currently contains:
- Release notes and documentation
- APK will be added here once built

## Building the APK
To build the APK for this release:

1. Follow the instructions in [BUILD_INSTRUCTIONS.md](../../BUILD_INSTRUCTIONS.md)
2. Use the automated build scripts:
   - [build-apk.sh](../../build-apk.sh) (Linux/Mac)
   - [build-apk.bat](../../build-apk.bat) (Windows)

## Testing the APK
Once the APK is built, comprehensive testing instructions are available in:
- [APK Testing Plan](../../APK_TESTING_PLAN.md)
- [Test Execution Guide](../../APK_TEST_EXECUTION_GUIDE.md)
- [Post-Build Testing Instructions](../../POST_BUILD_TESTING_INSTRUCTIONS.md)

## Supported Devices
The app is designed to work on:
- Nothing Phone 2
- Pixel phones
- Most Android 7.0+ devices

## Changelog
- Added comprehensive APK testing framework
- Enhanced build scripts to include test suite
- Created detailed documentation for testing process
- Improved post-installation configuration

## Next Steps
1. Build the APK using the provided build instructions
2. Place the built APK in this directory
3. Update this README to reflect the availability of the APK
4. Test the APK on target devices
5. Document test results