# Termux Crush App APK Testing

This document provides an overview of the testing process for the Termux Crush App APK.

## Overview

The Termux Crush App is a custom Android application that bundles Termux with the Crush CLI pre-installed. This testing process ensures the APK functions correctly on Android devices, particularly Nothing Phone 2 and Pixel devices, without conflicts with existing Termux installations.

## Testing Components

This repository includes several components to facilitate APK testing:

1. **APK_TESTING_PLAN.md** - Comprehensive test plan covering all aspects
2. **APK_TESTING_EXECUTION_GUIDE.md** - Step-by-step testing instructions
3. **APK_TESTING_REPORT_TEMPLATE.md** - Standardized test report template
4. **APK_TESTING_SUMMARY.md** - Summary of testing process and components
5. **POST_BUILD_TESTING_INSTRUCTIONS.md** - Instructions for testing after building
6. **scripts/test-suite.sh** - Automated test suite for Termux environment
7. **scripts/test-suite.bat** - Windows wrapper for test suite

## Quick Start

1. Build the APK using the build instructions in BUILD_INSTRUCTIONS.md
2. Follow the POST_BUILD_TESTING_INSTRUCTIONS.md guide
3. Execute tests on target devices
4. Document results using the APK_TESTING_REPORT_TEMPLATE.md

## Target Devices

Testing should be performed on:
- Nothing Phone 2 (primary target)
- Pixel 4/5/6/7 devices
- Android Emulator (API 28+)

## Key Features to Verify

1. **Installation**: Clean installation without conflicts
2. **Crush CLI**: Full functionality of the AI assistant
3. **Integrated Tools**: Vim, Neovim, Git, Go language support
4. **Device Compatibility**: Proper operation on target devices
5. **Performance**: Acceptable resource usage
6. **Security**: Appropriate permissions and data handling

## Automated Testing

The repository includes an automated test suite that can be run within the Termux environment:

```bash
# After installing the APK and launching the app
/share/crush/scripts/test-suite.sh
```

This script tests:
- Installation verification
- Command availability
- Basic functionality
- Configuration management

## Manual Testing

In addition to automated tests, perform manual testing of:

1. Interactive Crush CLI sessions
2. File editing with Vim/Neovim
3. Git repository management
4. Go development workflows
5. Session persistence
6. Device-specific UI/UX

## Reporting Issues

When issues are found:

1. Document the exact steps to reproduce
2. Include device model and Android version
3. Capture screenshots or logs if applicable
4. Submit using the testing report template

## Support

For questions about the testing process, refer to the documentation in this repository or contact the development team.