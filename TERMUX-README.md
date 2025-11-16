# Crush for Termux (Android)

This is a modified version of Crush that works on Termux for Android 15+ without root access.

## What is Crush?

Crush is a powerful terminal-based AI assistant that helps with software development tasks. It provides an interactive chat interface with AI capabilities, code analysis, and LSP integration to assist developers in writing, debugging, and understanding code directly from the terminal.

## Features

- **Multi-Model:** Choose from a wide range of LLMs including Google Gemini, OpenAI GPT, Anthropic Claude, and more
- **Flexible:** Switch LLMs mid-session while preserving context
- **Session-Based:** Maintain multiple work sessions and contexts per project
- **LSP-Enhanced:** Crush uses LSPs for additional context, just like you do
- **Extensible:** Add capabilities via MCPs (`http`, `stdio`, and `sse`)
- **Works on Termux:** First-class support for Android devices through Termux

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
   go install github.com/JlovesYouGit/termux-crush@latest
   ```
5. Run Crush:
   ```bash
   crush
   ```

## API Key Setup

To use Crush with AI models, you'll need to set up API keys:

```bash
# For Google Gemini
export GEMINI_API_KEY="your-api-key-here"

# For OpenAI
export OPENAI_API_KEY="your-api-key-here"

# For Anthropic
export ANTHROPIC_API_KEY="your-api-key-here"
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

## Termux-Specific Enhancements

This version of Crush includes several enhancements specifically for the Termux environment:

1. **Platform Detection**: Automatically detects Termux environment using `TERMUX_VERSION` environment variable
2. **Proper Directory Handling**: Uses standard XDG directory structure (`~/.config/crush/` and `~/.local/share/crush/`)
3. **Go-Based Implementation**: Avoids Rust compilation issues common in Termux
4. **No Root Required**: Works on any Android device with Termux installed

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

## Contributing

We welcome contributions to improve Crush's Termux compatibility! Please feel free to submit issues and pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

- Based on the original [Crush](https://github.com/charmbracelet/crush) project by Charm
- Thanks to the Termux community for their excellent Android terminal emulator