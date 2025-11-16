# APK Test Execution Guide

This guide explains how to test the Termux Crush App APK on Android devices to verify its functionality.

## Prerequisites

1. Android device (Nothing Phone 2, Pixel, or other Android 7.0+ device)
2. USB cable for connecting to computer (if testing via ADB)
3. Computer with ADB installed (optional)
4. Internet connection

## Installation Testing

### Step 1: Transfer APK to Device
Transfer the APK file to your Android device using one of these methods:
- Email attachment
- Cloud storage (Google Drive, Dropbox, etc.)
- USB transfer
- ADB: `adb push termux-crush-app.apk /sdcard/Download/`

### Step 2: Enable Unknown Sources
1. Go to Settings > Apps & notifications > Special app access
2. Tap "Install unknown apps"
3. Select your file manager or browser
4. Enable "Allow from this source"

### Step 3: Install the APK
1. Open the file manager
2. Navigate to where you saved the APK
3. Tap on the APK file
4. Tap "Install"
5. Wait for installation to complete

## Functional Testing

### Step 1: First Launch
1. Find "Termux Crush App" in your app drawer
2. Tap to launch the app
3. Observe the initialization process
4. Note any errors or unusual behavior

### Step 2: Verify Installation
After the app initializes, verify the following commands work:

```bash
# Check Crush CLI
crush --help

# Check version
crush --version

# Check directories
crush dirs

# Check other installed tools
git --version
go version
vim --version
nvim --version
```

### Step 3: Test Core Functionality
1. Run Crush in interactive mode:
   ```bash
   crush
   ```
2. Test basic commands:
   ```bash
   crush run "What is 2+2?"
   ```

### Step 4: Test Integrated Features
1. Test Vim editor:
   ```bash
   vim test.txt
   # Enter some text, save and exit
   ```

2. Test Neovim editor:
   ```bash
   nvim test2.txt
   # Enter some text, save and exit
   ```

3. Test Git functionality:
   ```bash
   mkdir test-repo
   cd test-repo
   git init
   echo "test" > test.txt
   git add test.txt
   git commit -m "Test commit"
   ```

4. Test Go development:
   ```bash
   echo 'package main
   import "fmt"
   func main() {
       fmt.Println("Hello, Termux!")
   }' > hello.go
   
   go run hello.go
   go build hello.go
   ```

## Automated Testing

If you have access to the test suite script:

1. Transfer the test script to your device:
   ```bash
   # If using ADB
   adb push scripts/test-suite.sh /sdcard/Download/
   ```

2. In Termux, copy and make the script executable:
   ```bash
   cp /sdcard/Download/test-suite.sh ~/
   chmod +x ~/test-suite.sh
   ```

3. Run the test suite:
   ```bash
   ~/test-suite.sh
   ```

## Device-Specific Testing

### Nothing Phone 2
1. Pay special attention to UI elements and sizing
2. Test any Nothing-specific features or integrations
3. Note performance characteristics

### Pixel Devices
1. Verify compatibility across different Pixel models
2. Check for any Pixel-specific optimizations

## Conflict Testing

If you have the standard Termux app installed:

1. Launch standard Termux app
2. Verify it still functions correctly
3. Launch Termux Crush App
4. Verify it functions correctly
5. Switch between apps multiple times
6. Confirm no data conflicts occur

## Performance Monitoring

During testing, monitor:

1. App startup time
2. Memory usage
3. Battery consumption
4. Responsiveness during AI interactions

## Reporting Issues

If you encounter any issues:

1. Note the exact steps to reproduce
2. Capture screenshots if applicable
3. Record any error messages
4. Document the device model and Android version
5. Include the APK version being tested

## Test Completion

After completing all tests:

1. Fill out the testing report template
2. Attach any relevant screenshots or logs
3. Submit the report to the development team