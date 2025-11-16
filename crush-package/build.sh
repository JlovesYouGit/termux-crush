#!/bin/bash

TERMUX_PKG_HOMEPAGE=https://github.com/JlovesYouGit/termux-crush
TERMUX_PKG_DESCRIPTION="Terminal-based AI assistant for software development"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@JlovesYouGit"
TERMUX_PKG_VERSION="1.0.0"
TERMUX_PKG_SRCURL=https://github.com/JlovesYouGit/termux-crush/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=sha256sum-will-be-calculated-during-build
TERMUX_PKG_DEPENDS="golang, git"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	termux_setup_golang
	
	# Ensure we're using modules
	export GO111MODULE=on
	
	# Clean and prepare module
	go mod tidy
	
	# Build the binary
	go build -o crush .
}

termux_step_make_install() {
	# Install the binary
	install -Dm700 -t $TERMUX_PREFIX/bin crush
	
	# Create necessary directories
	mkdir -p $HOME/.config/crush
	mkdir -p $HOME/.local/share/crush
}

termux_step_post_make_install() {
	# Create a simple config file
	cat > $TERMUX_PREFIX/etc/crush.conf << EOF
# Crush CLI Configuration
# Default configuration for Termux Crush App
data_dir = "$HOME/.local/share/crush"
config_dir = "$HOME/.config/crush"
EOF

	# Install test suite
	install -Dm755 -t $TERMUX_PREFIX/share/crush/scripts $TERMUX_PKG_BUILDER_DIR/test-suite.sh
}