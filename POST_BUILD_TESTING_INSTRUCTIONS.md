# Post-Build Testing Instructions

This document provides instructions for testing the Termux Crush App APK after it has been built.

## Prerequisites

1. Built APK file (termux-crush-app.apk)
2. Android device or emulator (Android 7.0+)
3. USB cable (for physical device testing)
4. ADB installed on your computer (optional but recommended)

## Testing Process

### Step 1: Transfer APK to Test Device

#### Option A: Physical Device
1. Connect your Android device to your computer via USB
2. Transfer the APK file:
   ```
   adb install termux-crush-app.apk
   ```
   
   Or manually transfer:
   - Email the APK to yourself
   - Use a cloud storage service
   - Use a file transfer app

#### Option B: Android Emulator
1. Start your Android emulator
2. Transfer the APK file:
   ```
   adb install termux-crush-app.apk
   ```

### Step 2: Install the APK

1. On your Android device, locate the APK file
2. Tap on the APK file to begin installation
3. If prompted, enable "Install unknown apps" for your file manager/browser
4. Confirm installation when prompted
5. Wait for installation to complete

### Step 3: Initial Launch and Setup

1. Find "Termux Crush App" in your app drawer
2. Tap to launch the app
3. Observe the initialization process:
   - Package installation
   - Environment setup
   - First-time configuration
4. Note any errors or unusual behavior

### Step 4: Verify Installation

After the app initializes, verify all components are installed:

```bash
# Check Crush CLI
crush --help

# Check versions
crush --version
git --version
go version
vim --version
nvim --version

# Check directories
crush dirs
ls -la ~/.config/crush/
ls -la ~/.local/share/crush/
```

### Step 5: Run Automated Test Suite

The test suite is included in the package and can be run to verify functionality:

```bash
# Run the automated test suite
/share/crush/scripts/test-suite.sh
```

If the test suite is not in that location, you can find it with:
```bash
find / -name "test-suite.sh" 2>/dev/null
```

### Step 6: Manual Functional Testing

#### Test Crush CLI
1. Run interactive mode:
   ```bash
   crush
   ```
2. Test basic commands:
   ```bash
   crush run "What is the capital of France?"
   ```

#### Test Integrated Editors
1. Test Vim:
   ```bash
   vim test.txt
   # Enter text, save (:wq)
   ```
2. Test Neovim:
   ```bash
   nvim test2.txt
   # Enter text, save (:wq)
   ```

#### Test Git Functionality
```bash
mkdir test-repo
cd test-repo
git init
echo "test content" > test.txt
git add test.txt
git commit -m "Initial commit"
```

#### Test Go Development
```bash
echo 'package main
import "fmt"
func main() {
    fmt.Println("Hello, Termux!")
}' > hello.go

go run hello.go
go build hello.go
./hello
```

### Step 7: Device-Specific Testing

#### Nothing Phone 2
1. Verify UI elements display correctly
2. Test any Nothing-specific features
3. Monitor performance and battery usage

#### Pixel Devices
1. Verify compatibility across different Pixel models
2. Check for any Pixel-specific optimizations
3. Monitor performance and battery usage

### Step 8: Conflict Testing

If you have the standard Termux app installed:

1. Launch standard Termux app
2. Verify it still functions correctly
3. Launch Termux Crush App
4. Verify it functions correctly
5. Switch between apps multiple times
6. Confirm no data conflicts occur

### Step 9: Performance Monitoring

During testing, monitor:

1. App startup time
2. Memory usage:
   ```bash
   top -p $(pgrep -f termux)
   ```
3. Battery consumption
4. Responsiveness during AI interactions

### Step 10: Document Results

Use the provided testing report template to document your results:
- APK_TESTING_REPORT_TEMPLATE.md

Include:
- Screenshots of any issues
- Log files if applicable
- Performance metrics
- Recommendations for improvements

## Troubleshooting

### Common Issues

#### App Crashes on Launch
- Clear app data and cache
- Reinstall the APK
- Check device compatibility

#### Commands Not Found
- Verify package installation
- Check PATH environment variable
- Restart the app

#### Permission Errors
- Check app permissions in Settings
- Ensure sufficient storage space
- Verify file system access

#### Network Issues
- Verify internet connection
- Check firewall settings
- Test API keys if using AI features

## Support

If you encounter issues during testing:

1. Check the GitHub issues page for known issues
2. Review the TERMUX_TESTING.md documentation
3. Contact the development team with detailed information:
   - Device model and Android version
   - Steps to reproduce the issue
   - Error messages or logs
   - Screenshots if applicable

## Completion

After completing all tests:

1. Fill out the testing report template
2. Submit the report to the development team
3. If all tests pass, the APK is ready for release