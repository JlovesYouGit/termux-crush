# Termux Crush App User Guide

## Introduction

The Termux Crush App is a custom Android application that bundles Termux with the Crush CLI pre-installed. This allows you to use the powerful Crush AI assistant on your Android device without any setup.

## Installation

1. Download the latest APK from the releases page
2. Install the APK on your Android device
3. Launch the app

## First Launch

When you first launch the app, it will automatically:
- Set up the Termux environment
- Install all required packages
- Configure Crush CLI for immediate use

You'll see a welcome message with available commands.

## Using Crush CLI

To start the Crush AI assistant, simply type:

```bash
crush
```

This will launch the interactive CLI interface where you can:
- Chat with AI models like Gemini
- Get help with coding tasks
- Analyze and debug code
- Control your Android device through commands

### Basic Commands

- `crush` - Start interactive mode
- `crush --help` - Show help information
- `crush run "command"` - Run a single command
- `crush -d` - Run with debug logging

## Editing Files

The app includes both Vim and Neovim for file editing:

### Vim
```bash
vim filename.txt
```

### Neovim
```bash
nvim filename.txt
```

## Version Control

Git is pre-installed for version control:

```bash
git clone https://github.com/user/repo.git
git add .
git commit -m "Your message"
git push
```

## Go Development

Go is pre-installed for development:

```bash
go run main.go
go build -o myapp .
go install github.com/user/package@latest
```

## Managing Packages

You can install additional packages using the standard Termux package manager:

```bash
pkg update
pkg install package-name
```

## Troubleshooting

### Common Issues

1. **App crashes on startup**: Try clearing app data and restarting
2. **Network issues**: Ensure you have internet permission enabled
3. **Storage issues**: Check available storage space

### Getting Help

If you encounter issues:
1. Check the app logs in Settings > Apps > Termux Crush > Storage & cache > Clear storage
2. Report issues on GitHub: https://github.com/JlovesYouGit/termux-crush/issues

## Advanced Usage

### Custom Configuration

You can customize Crush behavior by editing the configuration file:

```bash
vim ~/.config/crush/config.json
```

### Environment Variables

Set environment variables in your shell profile:

```bash
echo 'export MY_VAR="value"' >> ~/.bashrc
```

### Aliases

Create command aliases for frequently used commands:

```bash
echo 'alias ll="ls -la"' >> ~/.bashrc
```

## Supported Devices

The app is designed to work on:
- Nothing Phone 2
- Pixel phones
- Most Android 7.0+ devices

## Performance Tips

1. Close unused sessions to free up memory
2. Use `exit` command to close terminal sessions
3. Restart the app periodically for optimal performance

## Security

The app follows standard Android security practices:
- No root required
- No special permissions beyond standard terminal app permissions
- All data stored locally on your device