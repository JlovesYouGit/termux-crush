# APK Testing Plan for Termux Crush App

## Overview
This document outlines the comprehensive testing plan for the Termux Crush App APK to ensure it functions correctly on Android devices, particularly Nothing Phone 2 and Pixel devices, without conflicts with existing Termux installations.

## Test Environment Setup

### Android Virtual Environment
1. Set up Android Emulator with API level 28+ (Android 9.0+)
2. Create AVD profiles for:
   - Pixel 3/4/5/6/7 (various sizes)
   - Nothing Phone 2 (if available, or similar aspect ratio device)
3. Ensure sufficient storage space (at least 2GB free)
4. Stable internet connection

### Physical Device Testing
1. Nothing Phone 2 (Android 12+)
2. Pixel 4/5/6/7 (Android 11+)
3. Ensure devices have at least 2GB free storage

## Pre-Testing Checklist

- [ ] APK file is available and accessible
- [ ] SHA256 checksum of APK verified
- [ ] Test devices/emulators are fully charged or plugged in
- [ ] Internet connection is stable
- [ ] Required API keys for testing are available (Gemini, OpenAI)

## Test Cases

### 1. Installation Tests

#### 1.1 Clean Installation
**Objective**: Verify the APK installs correctly without conflicts
**Steps**:
1. Ensure no existing Termux Crush App is installed
2. Install the APK file
3. Monitor installation process for errors
4. Verify app appears in app drawer

**Expected Results**:
- Installation completes without errors
- App icon appears in app drawer
- App launches without crashing

#### 1.2 Installation with Existing Termux
**Objective**: Verify no conflicts with existing Termux installations
**Steps**:
1. Install standard Termux from F-Droid
2. Install Termux Crush App APK
3. Launch both apps

**Expected Results**:
- Both apps install and run without conflicts
- Each app maintains separate data directories
- No package conflicts occur

### 2. First Launch Tests

#### 2.1 Initial Setup
**Objective**: Verify first-time setup process
**Steps**:
1. Launch app for the first time
2. Observe initialization process
3. Check for automatic package installation
4. Verify Crush CLI availability

**Expected Results**:
- App initializes environment correctly
- All required packages (git, golang, vim, neovim, crush) are installed
- Crush CLI is available via `crush --help`

#### 2.2 Configuration Creation
**Objective**: Verify configuration files are created correctly
**Steps**:
1. After first launch, check configuration directories:
   - `$HOME/.config/crush/`
   - `$HOME/.local/share/crush/`
2. Verify config.json is created with correct structure

**Expected Results**:
- Configuration directories are created
- config.json contains proper structure with data_directory, debug, permissions

### 3. Core Functionality Tests

#### 3.1 Crush CLI Basic Functionality
**Objective**: Verify Crush CLI works correctly
**Steps**:
1. Launch the app
2. Run `crush --help`
3. Run `crush --version`
4. Run `crush dirs`

**Expected Results**:
- Help text displays correctly
- Version information shows properly
- Data/config directories are displayed correctly

#### 3.2 Interactive Mode
**Objective**: Verify interactive mode works
**Steps**:
1. Run `crush`
2. Enter a simple prompt: "What is 2+2?"
3. Observe response

**Expected Results**:
- Interactive mode starts without errors
- Simple prompts receive responses
- UI is responsive

#### 3.3 API Integration
**Objective**: Verify AI model integration works
**Steps**:
1. Set up API key in environment:
   `export GEMINI_API_KEY="test-key"`
2. Run `crush`
3. Enter a prompt requiring AI: "Explain quantum computing in simple terms"

**Expected Results**:
- API key is accepted
- AI responses are received (or appropriate error messages if key is invalid)

### 4. Integrated Features Tests

#### 4.1 Vim/Neovim Editor
**Objective**: Verify integrated editors work
**Steps**:
1. Run `vim test.txt`
2. Enter some text and save
3. Run `nvim test2.txt`
4. Enter some text and save

**Expected Results**:
- Both editors launch correctly
- Text can be entered and saved
- Files are accessible in filesystem

#### 4.2 Git Integration
**Objective**: Verify Git functionality
**Steps**:
1. Run `git --version`
2. Create a test repository:
   ```bash
   mkdir test-repo
   cd test-repo
   git init
   echo "test" > test.txt
   git add test.txt
   git commit -m "Initial commit"
   ```

**Expected Results**:
- Git is available and functional
- Repositories can be created and managed
- Commits work correctly

#### 4.3 Go Language Support
**Objective**: Verify Go development environment
**Steps**:
1. Run `go version`
2. Create a simple Go program:
   ```bash
   echo 'package main
   import "fmt"
   func main() {
       fmt.Println("Hello, Termux!")
   }' > hello.go
   ```
3. Run `go run hello.go`
4. Run `go build hello.go`

**Expected Results**:
- Go is available and functional
- Go programs can be run and built
- No environment issues

### 5. Device-Specific Tests

#### 5.1 Nothing Phone 2
**Objective**: Verify compatibility with Nothing Phone 2
**Steps**:
1. Install on Nothing Phone 2
2. Test all core functionalities
3. Check UI responsiveness
4. Verify performance

**Expected Results**:
- App functions correctly on Nothing Phone 2
- UI is responsive and properly sized
- No device-specific crashes or issues

#### 5.2 Pixel Devices
**Objective**: Verify compatibility with Pixel devices
**Steps**:
1. Install on various Pixel devices (4, 5, 6, 7)
2. Test all core functionalities
3. Check UI responsiveness
4. Verify performance

**Expected Results**:
- App functions correctly on all Pixel devices
- UI is responsive and properly sized
- No device-specific crashes or issues

### 6. Session and Persistence Tests

#### 6.1 Session Persistence
**Objective**: Verify session data is preserved
**Steps**:
1. Start a conversation in Crush
2. Ask several questions
3. Exit the app
4. Relaunch and check history

**Expected Results**:
- Previous conversations are accessible
- Session data is preserved between launches

#### 6.2 Configuration Persistence
**Objective**: Verify configuration changes are saved
**Steps**:
1. Modify configuration through Crush
2. Exit the app
3. Relaunch and verify settings

**Expected Results**:
- Configuration changes are preserved
- Settings are applied correctly

### 7. Performance Tests

#### 7.1 Memory Usage
**Objective**: Verify reasonable memory consumption
**Steps**:
1. Monitor memory usage during normal operation
2. Monitor during AI interactions
3. Check for memory leaks

**Expected Results**:
- Memory usage stays within reasonable limits
- No significant memory leaks
- Performance is acceptable on mid-range devices

#### 7.2 Battery Usage
**Objective**: Verify efficient battery usage
**Steps**:
1. Monitor battery usage during extended use
2. Check background battery consumption

**Expected Results**:
- Battery usage is reasonable
- No excessive background consumption

### 8. Security Tests

#### 8.1 Permissions
**Objective**: Verify appropriate permissions
**Steps**:
1. Check app permissions in settings
2. Verify only necessary permissions are requested
3. Test functionality with granted permissions

**Expected Results**:
- Only necessary permissions are requested
- App functions correctly with granted permissions
- No excessive permission requests

#### 8.2 Data Security
**Objective**: Verify data is stored securely
**Steps**:
1. Check location of data storage
2. Verify sensitive data is not exposed
3. Check file permissions

**Expected Results**:
- Data is stored in appropriate locations
- Sensitive data is protected
- File permissions are secure

## Test Execution

### Phase 1: Emulator Testing
1. Execute all test cases on Android Emulator
2. Document results
3. Identify and fix critical issues

### Phase 2: Physical Device Testing
1. Execute all test cases on Nothing Phone 2
2. Execute all test cases on Pixel devices
3. Document results
4. Identify and fix device-specific issues

### Phase 3: Conflict Testing
1. Install standard Termux
2. Install Termux Crush App
3. Test both apps function independently
4. Document results

## Success Criteria

The APK is considered to pass testing if:
- All installation tests pass
- Core functionality works on all tested devices
- No conflicts with existing Termux installations
- Integrated features (vim, neo, Crush CLI) work correctly
- Performance is acceptable
- Security standards are met
- Device-specific optimizations work

## Reporting

Test results will be documented in:
- PASS/FAIL status for each test case
- Screenshots for visual issues
- Log files for debugging
- Performance metrics
- Recommendations for improvements