#!/bin/bash
# Script to package a complete release with the built APK
# This script should be run after the APK is built

echo "Packaging Termux Crush App Release"
echo "==================================="

# Check if we're in the right directory
if [ ! -d "releases" ]; then
    echo "Error: releases directory not found. Run this script from the project root."
    exit 1
fi

# Define version
VERSION="v1.0.0"
RELEASE_DIR="releases/$VERSION"

echo "Preparing release package for version $VERSION..."

# Check if APK exists
if [ ! -f "$RELEASE_DIR/termux-crush-app-$VERSION.apk" ]; then
    echo "Warning: APK file not found. Please build the APK first."
    echo "The package will be created without the APK file."
    APK_EXISTS=false
else
    echo "Found APK file."
    APK_EXISTS=true
fi

# Generate checksums if APK exists
if [ "$APK_EXISTS" = true ]; then
    echo "Generating checksums..."
    cd "$RELEASE_DIR"
    
    # Generate SHA256 checksum
    sha256sum "termux-crush-app-$VERSION.apk" > CHECKSUMS.txt
    
    # Generate MD5 checksum
    md5sum "termux-crush-app-$VERSION.apk" >> CHECKSUMS.txt
    
    cd ../..
    echo "Checksums generated."
fi

# Create a complete package directory
PACKAGE_DIR="releases/package-$VERSION"
echo "Creating complete package directory: $PACKAGE_DIR"
mkdir -p "$PACKAGE_DIR"

# Copy all necessary files to the package directory
echo "Copying files to package directory..."

# Copy documentation
cp README.md "$PACKAGE_DIR/"
cp USER_GUIDE.md "$PACKAGE_DIR/"
cp BUILD_INSTRUCTIONS.md "$PACKAGE_DIR/"
cp DEPLOYMENT_INSTRUCTIONS.md "$PACKAGE_DIR/"

# Copy testing documentation
cp APK_TESTING_PLAN.md "$PACKAGE_DIR/"
cp APK_TESTING_README.md "$PACKAGE_DIR/"
cp APK_TESTING_REPORT_TEMPLATE.md "$PACKAGE_DIR/"
cp APK_TESTING_SUMMARY.md "$PACKAGE_DIR/"
cp APK_TEST_EXECUTION_GUIDE.md "$PACKAGE_DIR/"
cp POST_BUILD_TESTING_INSTRUCTIONS.md "$PACKAGE_DIR/"

# Copy build scripts
cp build-apk.sh "$PACKAGE_DIR/"
cp build-apk.bat "$PACKAGE_DIR/"
cp build-termux-crush-app.sh "$PACKAGE_DIR/"
cp build-termux-crush-app.bat "$PACKAGE_DIR/"

# Copy configuration files
cp manifest.json "$PACKAGE_DIR/"
cp -r config "$PACKAGE_DIR/"

# Copy package definition
cp -r crush-package "$PACKAGE_DIR/"

# Copy scripts
cp -r scripts "$PACKAGE_DIR/"

# Copy release files if they exist
if [ -f "$RELEASE_DIR/termux-crush-app-$VERSION.apk" ]; then
    cp "$RELEASE_DIR/termux-crush-app-$VERSION.apk" "$PACKAGE_DIR/"
fi

if [ -f "$RELEASE_DIR/CHECKSUMS.txt" ]; then
    cp "$RELEASE_DIR/CHECKSUMS.txt" "$PACKAGE_DIR/"
fi

# Copy release notes
cp "$RELEASE_DIR/RELEASE_NOTES.md" "$PACKAGE_DIR/"

# Create a package README
cat > "$PACKAGE_DIR/README.md" << 'EOF'
# Termux Crush App Complete Package

This is a complete package of the Termux Crush App v1.0.0.

## Contents
- APK file (if built)
- Complete source code
- Build scripts
- Testing framework
- Documentation
- Configuration files

## Installation
If the APK file is included:
1. Transfer the APK to your Android device
2. Enable "Install unknown apps" in Settings
3. Tap on the APK file to install

If the APK file is not included:
1. Follow the build instructions in BUILD_INSTRUCTIONS.md
2. Use the build scripts to create the APK
3. Install the generated APK

## Usage
After installation, the app will automatically:
- Set up the Termux environment
- Install all required packages
- Configure Crush CLI for immediate use

You can then use commands like:
```bash
crush
```

To start the Crush CLI interface.

## Testing
To test the app:
1. Follow the instructions in POST_BUILD_TESTING_INSTRUCTIONS.md
2. Run the automated test suite: `/share/crush/scripts/test-suite.sh`
3. Perform manual testing using the APK_TESTING_PLAN.md

## Building from Source
To build the APK from source:
1. Ensure you have the prerequisites (Android Studio, Docker, Git)
2. Follow the instructions in BUILD_INSTRUCTIONS.md
3. Use the build scripts:
   - build-apk.sh (Linux/Mac)
   - build-apk.bat (Windows)

## Support
For issues with this package:
1. Check the documentation included in this package
2. Visit the GitHub repository: https://github.com/JlovesYouGit/termux-crush
3. Submit issues to the GitHub issue tracker
EOF

echo "Package creation complete!"

# Create a zip file of the package
echo "Creating zip archive..."
cd releases
zip -r "termux-crush-app-$VERSION-complete-package.zip" "package-$VERSION"
cd ..

echo "Complete package created: releases/termux-crush-app-$VERSION-complete-package.zip"

echo ""
echo "Release package is ready!"
echo "========================"
echo "The complete package includes:"
echo "- All source code"
echo "- Build scripts"
echo "- Testing framework"
echo "- Documentation"
echo "- Configuration files"
echo "- APK file (if built)"
echo "- Checksums (if APK was built)"
echo ""
echo "To distribute this release:"
echo "1. Upload the zip file to GitHub releases"
echo "2. If the APK was built, also upload it separately"
echo "3. Update the release notes on GitHub"