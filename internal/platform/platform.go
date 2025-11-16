// Package platform provides utilities for detecting the platform Crush is running on.
package platform

import (
	"os"
	"runtime"
	"strings"
)

// IsTermux checks if Crush is running in a Termux environment.
func IsTermux() bool {
	// TERMUX_VERSION is a reliable way to detect Termux
	_, exists := os.LookupEnv("TERMUX_VERSION")
	return exists
}

// IsAndroid checks if Crush is running on Android.
func IsAndroid() bool {
	return runtime.GOOS == "android"
}

// IsWindows checks if Crush is running on Windows.
func IsWindows() bool {
	return runtime.GOOS == "windows"
}

// DataDir returns the appropriate data directory for the platform.
func DataDir(homeDir string) string {
	// For Termux, we should use the standard XDG paths even though they might not be set
	// Termux follows standard Unix conventions in most cases
	if IsTermux() || IsAndroid() {
		// In Termux, we can use the standard XDG paths or fall back to ~/.local/share
		xdgDataHome := os.Getenv("XDG_DATA_HOME")
		if xdgDataHome != "" {
			return xdgDataHome
		}
		// Default to ~/.local/share in Termux
		return homeDir + "/.local/share"
	}
	
	// For other platforms, return empty string to use default behavior
	return ""
}

// ConfigDir returns the appropriate config directory for the platform.
func ConfigDir(homeDir string) string {
	// For Termux, we should use the standard XDG paths even though they might not be set
	if IsTermux() || IsAndroid() {
		// In Termux, we can use the standard XDG paths or fall back to ~/.config
		xdgConfigHome := os.Getenv("XDG_CONFIG_HOME")
		if xdgConfigHome != "" {
			return xdgConfigHome
		}
		// Default to ~/.config in Termux
		return homeDir + "/.config"
	}
	
	// For other platforms, return empty string to use default behavior
	return ""
}