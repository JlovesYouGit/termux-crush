# Crush for Termux (Android)

This is a modified version of Crush that works on Termux for Android 15+ without root access.

## Installation on Termux

1. Install Termux from F-Droid (recommended) or GitHub
2. Update packages:
   ```bash
   pkg update && pkg upgrade
   ```
3. Install dependencies:
   ```bash
   pkg install golang git
   ```
4. Install Crush:
   ```bash
   go install github.com/charmbracelet/crush@latest
   ```
5. Run Crush:
   ```bash
   crush
   ```

## Changes Made for Termux Compatibility

1. Added platform detection for Termux environment
2. Modified data directory handling to work with Termux's file system
3. Ensured proper XDG directory usage in Termux

## API Key Setup

To use Crush with AI models like Gemini, you'll need to set up API keys:

```bash
# For Google Gemini
export GEMINI_API_KEY="your-api-key-here"

# For OpenAI
export OPENAI_API_KEY="your-api-key-here"
```

You can add these to your `~/.bashrc` or `~/.zshrc` file to make them persistent.

## Usage

Once installed, you can use Crush just like on any other platform:

```bash
# Start interactive session
crush

# Run a single command
crush run "Explain how Termux works on Android"

# Use with specific model
crush --model gemini-2.0-flash-exp
```

## Troubleshooting

If you encounter issues:

1. Make sure you have internet access
2. Verify your API keys are set correctly
3. Check that you have sufficient storage space
4. Try running with debug mode:
   ```bash
   crush --debug
   ```

## Limitations

- Some advanced features may not work due to Android restrictions
- File system access is limited to Termux's private directory
- Performance may be slower than on desktop systems