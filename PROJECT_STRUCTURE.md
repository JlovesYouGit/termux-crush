# Project Structure

This document explains the structure of the Termux Crush Android application.

## Overall Structure

```
TermuxCrushApp/
├── app/                          # Android application module
│   ├── src/                      # Source code
│   │   ├── main/                 # Main source set
│   │   │   ├── java/             # Kotlin source files
│   │   │   ├── res/              # Resources (layouts, values, etc.)
│   │   │   └── AndroidManifest.xml # Application manifest
│   │   └── test/                 # Unit tests
│   ├── build.gradle.kts          # Module-level build configuration
│   └── proguard-rules.pro        # ProGuard rules
├── gradle/                       # Gradle wrapper files
├── .github/                      # GitHub workflows
├── .gitignore                    # Git ignore file
├── build.gradle.kts              # Project-level build configuration
├── gradle.properties             # Gradle properties
├── gradlew                       # Gradle wrapper script (Unix)
├── gradlew.bat                   # Gradle wrapper script (Windows)
├── settings.gradle.kts           # Gradle settings
├── README.md                     # Project README
├── LICENSE                       # License file
├── CONTRIBUTING.md               # Contribution guidelines
├── RAPPED_INTEGRATION.md         # Rapped integration guide
└── PROJECT_STRUCTURE.md          # This file
```

## App Module Structure

### Source Code (`app/src/main/java/com/termux/crush/`)

1. **MainActivity.kt**
   - Main activity that hosts the application UI
   - Sets up the toolbar and basic app structure

2. **FirstFragment.kt**
   - Main UI fragment with Crush functionality
   - Handles user input and displays AI responses
   - Manages interactions with Rapped integration

3. **RappedIntegration.kt**
   - Helper class for integrating with Rapped application
   - Provides methods to check if Rapped is installed
   - Handles command execution through Rapped

### Resources (`app/src/main/res/`)

1. **layout/**
   - `activity_main.xml` - Main activity layout with toolbar
   - `content_main.xml` - Content area with navigation host
   - `fragment_first.xml` - Main UI with input and response display

2. **navigation/**
   - `nav_graph.xml` - Navigation graph for fragment navigation

3. **values/**
   - `colors.xml` - Color definitions
   - `strings.xml` - String resources
   - `themes.xml` - Theme definitions

4. **menu/**
   - `menu_main.xml` - Main activity menu

### Testing (`app/src/test/java/com/termux/crush/`)

1. **RappedIntegrationTest.kt**
   - Unit tests for Rapped integration functionality
   - Tests installation detection and command execution

## Build Configuration

### Project-level (`build.gradle.kts`)
- Defines build script dependencies
- Specifies plugin versions

### Module-level (`app/build.gradle.kts`)
- Application configuration (package name, SDK versions)
- Dependencies for Android components and testing
- Build types and compilation options

### Gradle Wrapper (`gradle/wrapper/`)
- Gradle distribution files
- Ensures consistent build environment

## GitHub Integration

### Workflows (`.github/workflows/`)
- `release.yml` - Automated APK building and GitHub release creation

## Scripts

### Build Scripts
- `gradlew` - Unix Gradle wrapper
- `gradlew.bat` - Windows Gradle wrapper
- `build_apk.bat` - Windows script to build APK

## Documentation

- `README.md` - Main project documentation
- `LICENSE` - MIT License
- `CONTRIBUTING.md` - Contribution guidelines
- `RAPPED_INTEGRATION.md` - Guide for Rapped integration
- `PROJECT_STRUCTURE.md` - This file

## Key Design Patterns

1. **Single Activity Architecture**
   - Uses one main activity with fragments
   - Navigation component for fragment management

2. **View Binding**
   - Type-safe view access
   - Null safety for UI components

3. **Fragment-based UI**
   - Modular UI components
   - Easy to extend with additional features

4. **Separation of Concerns**
   - UI logic in fragments
   - Business logic in separate classes
   - Integration logic in dedicated classes

## Future Expansion Points

1. **Additional Fragments**
   - Settings fragment
   - History fragment
   - About fragment

2. **Enhanced Integration**
   - Direct API connections for AI services
   - Advanced Rapped integration features

3. **UI Improvements**
   - Syntax highlighting for code snippets
   - Dark mode support
   - Custom themes

This structure provides a solid foundation for the Termux Crush application while maintaining flexibility for future enhancements.