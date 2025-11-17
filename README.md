# Termux Crush App

A Kotlin-based Android application that provides AI assistant functionality for Termux, working with Rapped.

## Overview

Termux Crush is an Android application that brings AI-powered coding assistance to your mobile device through Termux. It integrates with:
- Termux (Android terminal emulator)
- Termux:GUI plugin
- Rapped (Android app for enhanced Termux experience)

## Features

- AI-powered coding assistant for developers
- Natural language processing for coding questions
- Code snippet generation and explanation
- Integration with Termux through Rapped
- Copy and execute code directly in Termux
- Simple and intuitive user interface

## How It Works

1. **Ask Questions**: Type your coding questions or problems in natural language
2. **Get AI Assistance**: Receive AI-generated responses with code examples and explanations
3. **Execute in Termux**: Run the suggested commands directly in Termux through Rapped integration
4. **Copy to Clipboard**: Easily copy code snippets for manual execution

## Prerequisites

Before installing Termux Crush, ensure you have:
1. Termux installed from F-Droid (recommended)
2. Termux:GUI plugin installed
3. Rapped application installed

## Quick Start: Easy Building

The easiest way to build this app is using Android Studio:

1. **Download Android Studio** from https://developer.android.com/studio
2. **Open this project** in Android Studio
3. **Wait for Gradle sync** to complete
4. **Build the APK** via **Build** → **Build Bundle(s) / APK(s)** → **Build APK**

For detailed instructions, see our [Easy Build Guide](EASY_BUILD_GUIDE.md).

## Installation

### From APK (Recommended)

1. Download the latest APK from the Releases section
2. Install the APK on your Android device
3. Open the app and start using it with Termux

### Building from Source

1. Clone this repository
2. Open the project in Android Studio
3. Build the project:
   - Build → Build Bundle(s) / APK(s) → Build APK
4. Install the generated APK on your device

## Usage

1. Open Termux Crush
2. Type your coding question in the input field
3. Tap "Ask Crush" to get AI assistance
4. Review the response:
   - Tap "Copy" to copy code to clipboard
   - Tap "Run in Termux" to execute through Rapped (coming in future versions)
5. Execute the commands in Termux as needed

## Integration with Rapped

This app is designed to work seamlessly with Rapped, which provides:
- Enhanced GUI for Termux commands
- Better integration between Android and Termux
- Simplified execution of commands

Future versions will include direct integration with Rapped for one-tap command execution.

## Development

This is a Kotlin Android application built with:
- Android Studio
- Kotlin programming language
- Material Design components
- Android Navigation Component

### Project Structure

```
app/
├── src/main/java/com/termux/crush/
│   ├── MainActivity.kt          # Main activity
│   └── FirstFragment.kt         # Main UI with Crush functionality
├── src/main/res/
│   ├── layout/                  # XML layout files
│   ├── navigation/              # Navigation graph
│   └── values/                  # String and color resources
└── build.gradle.kts            # App-level build configuration
```

### Building the APK

For the easiest build process, follow our [Easy Build Guide](EASY_BUILD_GUIDE.md).

Alternative manual build steps:
1. Open the project in Android Studio
2. Connect an Android device or start an emulator
3. Build the project:
   ```
   Build → Build Bundle(s) / APK(s) → Build APK
   ```
4. Locate the APK in the build outputs directory

## Troubleshooting

If you encounter issues while building or using the app, please check our [Troubleshooting Guide](TROUBLESHOOTING.md) which covers common issues and their solutions.

Common issues include:
- Gradle wrapper problems
- Missing Java installation
- SDK location issues
- Dependency download failures

## Future Enhancements

- Direct integration with Rapped for command execution
- Support for multiple AI providers (OpenAI, Anthropic, etc.)
- Syntax highlighting for code snippets
- History of previous questions and answers
- Offline mode with pre-trained models
- Voice input for hands-free coding assistance

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Based on the concept of Crush AI assistant for terminals
- Inspired by the Termux ecosystem
- Built for integration with Rapped