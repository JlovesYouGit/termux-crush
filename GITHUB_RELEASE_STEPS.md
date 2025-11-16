# GitHub Release Creation Steps

This document provides the exact steps to create a GitHub release with just the APK file.

## Current Status
We have prepared all necessary files for a GitHub release:
- `termux-crush-app-v1.0.0.apk` - Placeholder APK file
- `RELEASE.md` - Release notes
- `checksums.txt` - SHA256 checksum of the APK
- `BUILD_AND_RELEASE.md` - Instructions for building the actual APK

## Steps to Create GitHub Release

### 1. Navigate to GitHub Releases
1. Go to https://github.com/JlovesYouGit/termux-crush/releases
2. Click "Draft a new release"

### 2. Fill in Release Information
1. **Tag version**: `v1.0.0`
2. **Target**: Select branch `apk-testing-enhancements`
3. **Release title**: `Termux Crush App v1.0.0`

### 3. Add Release Notes
Copy and paste the content from `RELEASE.md` into the description field.

### 4. Upload Assets
1. Click "Attach binaries by dropping them here or selecting them"
2. Select `termux-crush-app-v1.0.0.apk` (the placeholder APK)
3. Also upload `checksums.txt`

### 5. Finalize Release
1. Check "This is a pre-release" (because it contains a placeholder APK)
2. Click "Publish release"

## Steps to Replace with Actual APK

Once someone builds the actual APK:

### 1. Build the Actual APK
Follow the instructions in `BUILD_AND_RELEASE.md` to build the actual APK.

### 2. Replace the APK in the Release
1. Go to https://github.com/JlovesYouGit/termux-crush/releases
2. Find the v1.0.0 release
3. Click "Edit release"
4. Delete the placeholder APK
5. Upload the actual APK (make sure it's named `termux-crush-app-v1.0.0.apk`)
6. Update `checksums.txt` with the new checksum:
   ```bash
   sha256sum termux-crush-app-v1.0.0.apk > checksums.txt
   ```
7. Re-upload `checksums.txt`
8. Update the release notes to indicate it now contains the actual APK
9. Uncheck "This is a pre-release"
10. Click "Update release"

## Verification

After creating the release, verify that:
1. The release appears at https://github.com/JlovesYouGit/termux-crush/releases/tag/v1.0.0
2. The APK file is downloadable
3. The checksums file is downloadable
4. The release notes are properly formatted
5. The tag `v1.0.0` exists in the repository

## What Users Will Get

Users downloading this release will get:
- A single APK file (`termux-crush-app-v1.0.0.apk`) that they can install on their Android devices
- Checksums to verify the integrity of the APK
- Release notes explaining what the app does and how to use it

For users who want to build from source or access the complete documentation, they can clone the repository.