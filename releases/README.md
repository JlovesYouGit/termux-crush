# Termux Crush App Releases

This directory contains the official releases of the Termux Crush App.

## Release Structure

Each release is contained in its own directory named with the version number (e.g., v1.0.0).

## Current Release

### v1.0.0
- **Release Date**: November 16, 2025
- **Status**: Pre-release (APK to be built)
- **Features**:
  - Termux environment with all necessary dependencies pre-installed
  - Crush CLI ready to use out of the box
  - Integrated Vim/Neovim editor for easy code editing
  - No conflicts with existing Termux installations
  - Easy debugging and management tools
  - Comprehensive APK testing framework

## How to Get the APK

The APK file will be available in the version-specific directory once built.

## Building the APK

To build the APK yourself:

1. Follow the instructions in [BUILD_INSTRUCTIONS.md](../BUILD_INSTRUCTIONS.md)
2. Use the automated build scripts:
   - [build-apk.sh](../build-apk.sh) (Linux/Mac)
   - [build-apk.bat](../build-apk.bat) (Windows)

## Testing the APK

Comprehensive testing instructions are available in:
- [APK Testing Plan](../APK_TESTING_PLAN.md)
- [Test Execution Guide](../APK_TEST_EXECUTION_GUIDE.md)
- [Post-Build Testing Instructions](../POST_BUILD_TESTING_INSTRUCTIONS.md)

## Reporting Issues

If you encounter any issues with the APK, please:
1. Check the [GitHub issues](https://github.com/JlovesYouGit/termux-crush/issues)
2. Review the [Testing Report Template](../APK_TESTING_REPORT_TEMPLATE.md)
3. Submit a detailed issue report