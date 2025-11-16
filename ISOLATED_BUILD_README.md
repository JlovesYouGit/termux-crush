# Isolated Environment APK Build

This document explains how to build the Termux Crush App APK using an isolated Android SDK environment.

## Overview

The scripts in this directory allow you to build the APK without affecting your system's Android SDK installation. They create a self-contained environment with all necessary tools.

## Available Scripts

### Linux/Mac
- [setup-android-sdk.sh](setup-android-sdk.sh) - Sets up Android SDK in isolated environment
- [build-apk-venv.sh](build-apk-venv.sh) - Complete build process in isolated environment

### Windows
- [setup-android-sdk.bat](setup-android-sdk.bat) - Sets up Android SDK in isolated environment
- [build-apk-venv.ps1](build-apk-venv.ps1) - Complete build process in isolated environment

## Prerequisites

1. **Git** - For cloning repositories
2. **Docker** (optional but recommended) - For building Termux packages
3. **wget** or **curl** - For downloading Android SDK (included in most Linux distributions)

## Building the APK

### Option 1: Complete Isolated Build (Recommended)

This option sets up everything in an isolated environment and builds the APK:

**On Linux/Mac:**
```bash
bash build-apk-venv.sh
```

**On Windows:**
```powershell
powershell -ExecutionPolicy Bypass -File build-apk-venv.ps1
```

### Option 2: Setup SDK Only

If you want to just set up the Android SDK in an isolated environment:

**On Linux/Mac:**
```bash
bash setup-android-sdk.sh
```

**On Windows:**
```batch
setup-android-sdk.bat
```

## What the Build Process Does

1. **Sets up isolated Android SDK** - Downloads and configures Android command line tools
2. **Clones repositories** - Gets termux-app and termux-packages from GitHub
3. **Configures Crush package** - Sets up our custom package definition
4. **Builds packages** (if Docker available) - Creates bootstrap with pre-installed tools
5. **Configures app** - Updates package names and build settings
6. **Builds APK** - Uses Gradle to compile the Android application

## Output Files

After a successful build, you'll get:

- `termux-crush-app.apk` - The main APK file
- `termux-crush-app-venv-built.apk` - Copy with venv suffix
- `termux-crush-app-fallback.apk` - Fallback if main build fails (if applicable)

## Testing the APK

1. Transfer the APK to an Android device
2. Enable "Install unknown apps" in Settings
3. Tap on the APK file to install
4. Launch the app and verify:
   - Termux environment loads correctly
   - Crush CLI is available (`crush --help`)
   - Vim/Neovim editors work
   - Git and Go are available

## Troubleshooting

### Common Issues

1. **Permission denied**: Make scripts executable with `chmod +x *.sh`
2. **Docker not found**: Install Docker Desktop for your platform
3. **wget not found** (Windows): Install Git for Windows which includes wget
4. **Insufficient disk space**: The build process requires several GB of free space

### Build Failures

If the build fails:
1. Check the error messages in the console output
2. Ensure all prerequisites are installed
3. Try running the setup and build steps separately
4. Check that you have sufficient disk space and memory

## Customization

You can modify the build scripts to:
- Target different Android API levels
- Include additional packages
- Change the package name
- Adjust build parameters

## Cleaning Up

To remove the isolated environment:
```bash
rm -rf ~/termux-crush-build-venv
rm -rf ~/android-sdk-isolated
```

## Security Notes

- The APK built by these scripts is unsigned
- For production use, you should sign the APK with your own key
- The isolated environment ensures no system-wide changes are made