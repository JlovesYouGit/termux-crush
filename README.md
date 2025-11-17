# Termux Crush App

A custom Termux Android application with Crush CLI pre-installed for easy deployment on Android devices.

## Overview

This project creates a standalone Android application that bundles Termux with Crush CLI pre-installed. The app is designed to work on Android devices including  Phone 2 and Pixel phones without conflicting with existing Termux installations.

## Features

- Termux environment with all necessary dependencies pre-installed
- Crush CLI ready to use out of the box
- Integrated Vim/Neo editor for easy code editing
- No conflicts with existing Termux installations
- Easy debugging and management tools

## Building the App

1. Clone the Termux app source:
   ```bash
   git clone https://github.com/termux/termux-app
   ```

2. Refactor package name to avoid conflicts (e.g., com.termux.crush)

3. Build custom bootstrap with pre-installed packages:
   - Crush CLI
   - Git
   - Vim/Neo
   - Go language support

4. Build the APK using Android Studio

## Installation

1. Download the APK from releases
2. Install on your Android device
3. Launch the app and start using Crush CLI immediately

## Usage

After installation, the app will automatically:
- Set up the Termux environment
- Install all required packages
- Configure Crush CLI for immediate use

You can then use commands like:
```bash
crush
```

To start the Crush CLI interface.

## Testing

Comprehensive testing instructions and tools are provided in the APK testing documentation:

- [APK Testing Plan](../APK_TESTING_PLAN.md)
- [Test Execution Guide](../APK_TEST_EXECUTION_GUIDE.md)
- [Testing Report Template](../APK_TESTING_REPORT_TEMPLATE.md)
- [Post-Build Testing Instructions](../POST_BUILD_TESTING_INSTRUCTIONS.md)

Automated test suite is included in the package and can be run within the Termux environment.

## Contributing

Contributions are welcome! Please fork the repository and submit pull requests.
