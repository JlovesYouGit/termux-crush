#!/bin/bash
# Startup script for Termux Crush App
# This script runs when the app is first launched

echo "Welcome to Termux Crush App!"
echo "============================"
echo ""
echo "Initializing environment..."

# Create necessary directories
mkdir -p $HOME/.config/crush
mkdir -p $HOME/.local/share/crush

# Check if Crush is installed
if ! command -v crush &> /dev/null; then
    echo "Installing Crush CLI..."
    go install github.com/JlovesYouGit/termux-crush@latest
fi

# Check if this is the first run
if [ ! -f "$HOME/.config/crush/initialized" ]; then
    echo "First time setup..."
    
    # Create default configuration
    cat > $HOME/.config/crush/config.json << EOF
{
  "data_directory": "$HOME/.local/share/crush",
  "debug": false,
  "permissions": {
    "skip_requests": false
  },
  "first_run": false
}
EOF
    
    # Mark as initialized
    touch $HOME/.config/crush/initialized
    
    echo "Setup complete!"
    echo ""
    echo "Type 'crush' to start the AI assistant"
    echo "Type 'crush --help' for available commands"
fi

# Display welcome message
echo ""
echo "Available commands:"
echo "  crush        - Start the AI assistant"
echo "  vim          - Edit files with Vim"
echo "  nvim         - Edit files with Neovim"
echo "  git          - Version control"
echo "  go           - Go programming language"
echo ""
echo "For more information, visit: https://github.com/JlovesYouGit/termux-crush"