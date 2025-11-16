# Crush Package for Termux

This directory contains the package definition for Crush CLI to be included in the custom Termux build.

## Package Information

- Name: crush
- Version: latest
- Description: Terminal-based AI assistant for software development
- Dependencies: golang, git

## Package Structure

```
crush/
├── build.sh
├── crush.subpackage.sh
└── postinst
```

## Build Script

The [build.sh](file:///c%3A/Users/JJ/Downloads/lest/crush/scripts/build.sh) script defines how to build the Crush package:

```bash
TERMUX_PKG_HOMEPAGE=https://github.com/JlovesYouGit/termux-crush
TERMUX_PKG_DESCRIPTION="Terminal-based AI assistant for software development"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@JlovesYouGit"
TERMUX_PKG_VERSION=1.0.0
TERMUX_PKG_SRCURL=https://github.com/JlovesYouGit/termux-crush/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=<sha256-hash>
TERMUX_PKG_DEPENDS="golang, git"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
    termux_setup_golang
    go mod tidy
    go build -o crush .
}

termux_step_make_install() {
    install -Dm700 -t $TERMUX_PREFIX/bin crush
}
```

## Post-install Script

The [postinst](file:///c%3A/Users/JJ/Downloads/lest/crush/scripts/postinst) script runs after package installation:

```bash
#!/bin/sh
set -e
# Initialize Crush configuration
mkdir -p $HOME/.config/crush
mkdir -p $HOME/.local/share/crush
```

## Integration with Bootstrap

This package will be built as part of the custom bootstrap process and included in the Termux Crush App APK.