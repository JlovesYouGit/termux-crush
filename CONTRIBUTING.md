# Contributing to Termux Crush

Thank you for your interest in contributing to Termux Crush! This document provides guidelines and information to help you contribute effectively.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/your-username/termux-crush.git`
3. Create a new branch for your feature or bug fix: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Commit your changes: `git commit -am "Add some feature"`
6. Push to your fork: `git push origin feature/your-feature-name`
7. Create a pull request

## Development Setup

### Prerequisites

- Android Studio Arctic Fox or later
- Android SDK API level 21 or higher
- Kotlin 1.5 or higher
- JDK 8 or higher

### Building the Project

1. Open the project in Android Studio
2. Wait for Gradle to sync
3. Build the project: `Build → Make Project`

### Running Tests

```bash
# Run unit tests
./gradlew test

# Run instrumented tests
./gradlew connectedAndroidTest
```

## Code Style

We follow the official Kotlin coding conventions. Please ensure your code adheres to these standards:

1. Use descriptive variable and function names
2. Keep functions small and focused
3. Add comments for complex logic
4. Follow the existing code structure and patterns

### Code Formatting

Android Studio can automatically format your code:
- Format code: `Ctrl+Alt+L` (Windows/Linux) or `Cmd+Alt+L` (Mac)
- Organize imports: `Ctrl+Alt+O` (Windows/Linux) or `Cmd+Alt+O` (Mac)

## Pull Request Process

1. Ensure your code follows the project's coding standards
2. Write clear, descriptive commit messages
3. Include tests for new functionality
4. Update documentation as needed
5. Describe your changes in the pull request description
6. Link any related issues

## Reporting Issues

When reporting issues, please include:

1. A clear and descriptive title
2. Steps to reproduce the issue
3. Expected behavior
4. Actual behavior
5. Screenshots if applicable
6. Device information (Android version, etc.)
7. App version

## Feature Requests

We welcome feature requests! Please create an issue with:

1. A clear description of the feature
2. The problem it solves
3. How it would be used
4. Any implementation ideas (optional)

## Code of Conduct

Please note that this project is released with a Contributor Code of Conduct. By participating in this project you agree to abide by its terms.

## Questions?

If you have any questions about contributing, feel free to:

1. Create an issue
2. Contact the maintainers
3. Join our community discussions

Thank you for contributing to Termux Crush!