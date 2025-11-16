# GitHub Release Creation Instructions

This document provides step-by-step instructions for creating a GitHub release for the Termux Crush App with the prebuilt APK file.

## Prerequisites
- A GitHub account
- Write access to the repository https://github.com/JlovesYouGit/termux-crush
- The release package file: `termux-crush-app-v1.0.0-github-release.zip`

## Steps to Create the GitHub Release

### 1. Navigate to the Releases Page
1. Go to https://github.com/JlovesYouGit/termux-crush/releases
2. Click on "Draft a new release" (or "Create a new release")

### 2. Set Up Release Details
1. **Tag version**: Enter `v1.0.0`
2. **Target**: Select the `apk-testing-enhancements` branch (or merge to master first if preferred)
3. **Release title**: Enter `Termux Crush App v1.0.0`

### 3. Write Release Notes
Copy and paste the content from [GITHUB_RELEASE_NOTES.md](GITHUB_RELEASE_NOTES.md) into the description field, or write your own release notes including:

```
# Termux Crush App v1.0.0

## Overview
This release includes the Termux Crush App - a custom Android application that bundles Termux with Crush CLI pre-installed for easy deployment on Android devices.

**Note**: This is a pre-release with a placeholder APK. The actual APK needs to be built by someone with the Android development environment.

## Features
- Termux environment with all necessary dependencies pre-installed
- Crush CLI ready to use out of the box
- Integrated Vim/Neovim editor for easy code editing
- No conflicts with existing Termux installations
- Easy debugging and management tools
- Comprehensive APK testing framework

## What's Included
- Source code for the Termux Crush App
- Build scripts for creating the APK
- Comprehensive testing framework
- Detailed documentation
- Placeholder APK (needs to be replaced with actual build)

## Building the APK
To build the actual APK:

1. Clone this repository
2. Follow the instructions in [BUILD_INSTRUCTIONS.md](BUILD_INSTRUCTIONS.md)
3. Use the automated build scripts:
   - [build-apk.sh](build-apk.sh) (Linux/Mac)
   - [build-apk.bat](build-apk.bat) (Windows)
4. Replace the placeholder APK with the built APK
5. Update the release

## Testing the APK
Once the APK is built, comprehensive testing instructions are available in:
- [APK Testing Plan](APK_TESTING_PLAN.md)
- [Test Execution Guide](APK_TEST_EXECUTION_GUIDE.md)
- [Post-Build Testing Instructions](POST_BUILD_TESTING_INSTRUCTIONS.md)

## Supported Devices
The app is designed to work on:
- Nothing Phone 2
- Pixel phones
- Most Android 7.0+ devices
```

### 4. Upload Release Assets
1. Click "Attach binaries by dropping them here or selecting them"
2. Select the following files to upload:
   - `termux-crush-app-v1.0.0-github-release.zip` (the complete package)
   - `termux-crush-app-v1.0.0.apk` (if you have built the actual APK)

### 5. Finalize Release
1. Check "This is a pre-release" if you're uploading the placeholder APK
2. Click "Publish release"

## Updating the Release with Actual APK

Once someone builds the actual APK:

1. Go to the release page
2. Click "Edit release"
3. Replace the placeholder APK with the actual APK
4. Update the checksums file
5. Remove the "pre-release" flag
6. Update the release notes to indicate it now contains the actual APK
7. Click "Update release"

## Release Verification

After creating the release, verify that:
1. The tag `v1.0.0` exists in the repository
2. The release appears on the releases page
3. All assets are downloadable
4. The release notes are properly formatted
5. Links in the release notes work correctly

## Support

For issues with the release process:
1. Check the [GitHub repository](https://github.com/JlovesYouGit/termux-crush)
2. Review the documentation in this package
3. Submit issues to the GitHub issue tracker