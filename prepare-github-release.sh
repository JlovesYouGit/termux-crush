#!/bin/bash
# Script to prepare a GitHub release package
# This script creates a package that can be uploaded to GitHub releases

echo "Preparing GitHub Release Package"
echo "==============================="

# Define version
VERSION="v1.0.0"
RELEASE_DATE=$(date +"%Y-%m-%d")

echo "Creating release package for version $VERSION..."

# Create a temporary directory for the release
TEMP_DIR="temp-release-$VERSION"
echo "Creating temporary directory: $TEMP_DIR"
mkdir -p "$TEMP_DIR"

# Copy all necessary files to the release directory
echo "Copying files to release directory..."

# Copy documentation
cp README.md "$TEMP_DIR/"
cp USER_GUIDE.md "$TEMP_DIR/"
cp BUILD_INSTRUCTIONS.md "$TEMP_DIR/"
cp DEPLOYMENT_INSTRUCTIONS.md "$TEMP_DIR/"
cp GITHUB_RELEASE_NOTES.md "$TEMP_DIR/RELEASE_NOTES.md"

# Copy testing documentation
cp APK_TESTING_PLAN.md "$TEMP_DIR/"
cp APK_TESTING_README.md "$TEMP_DIR/"
cp APK_TESTING_REPORT_TEMPLATE.md "$TEMP_DIR/"
cp APK_TESTING_SUMMARY.md "$TEMP_DIR/"
cp APK_TEST_EXECUTION_GUIDE.md "$TEMP_DIR/"
cp POST_BUILD_TESTING_INSTRUCTIONS.md "$TEMP_DIR/"

# Copy build scripts
cp build-apk.sh "$TEMP_DIR/"
cp build-apk.bat "$TEMP_DIR/"
cp build-termux-crush-app.sh "$TEMP_DIR/"
cp build-termux-crush-app.bat "$TEMP_DIR/"
cp package-release.sh "$TEMP_DIR/"
cp package-release.bat "$TEMP_DIR/"

# Copy configuration files
cp manifest.json "$TEMP_DIR/"
cp -r config "$TEMP_DIR/"

# Copy package definition
cp -r crush-package "$TEMP_DIR/"

# Copy scripts
cp -r scripts "$TEMP_DIR/"

# Copy the APK (placeholder for now)
cp "releases/v1.0.0/termux-crush-app-$VERSION.apk" "$TEMP_DIR/"

# Copy checksums if they exist, otherwise create a placeholder
if [ -f "releases/v1.0.0/CHECKSUMS.txt" ]; then
    cp "releases/v1.0.0/CHECKSUMS.txt" "$TEMP_DIR/"
else
    echo "# Checksums for Termux Crush App $VERSION" > "$TEMP_DIR/CHECKSUMS.txt"
    echo "# This file will contain checksums for the APK once it is built" >> "$TEMP_DIR/CHECKSUMS.txt"
    echo "" >> "$TEMP_DIR/CHECKSUMS.txt"
    echo "# Format:" >> "$TEMP_DIR/CHECKSUMS.txt"
    echo "# <algorithm>:<checksum> <filename>" >> "$TEMP_DIR/CHECKSUMS.txt"
    echo "" >> "$TEMP_DIR/CHECKSUMS.txt"
    echo "# To generate checksums after building the APK:" >> "$TEMP_DIR/CHECKSUMS.txt"
    echo "# sha256sum termux-crush-app-$VERSION.apk > CHECKSUMS.txt" >> "$TEMP_DIR/CHECKSUMS.txt"
    echo "# md5sum termux-crush-app-$VERSION.apk >> CHECKSUMS.txt" >> "$TEMP_DIR/CHECKSUMS.txt"
fi

# Create a release info file
cat > "$TEMP_DIR/RELEASE_INFO.txt" << EOF
Termux Crush App Release $VERSION
Release Date: $RELEASE_DATE

This package contains:
- APK file (placeholder - needs to be replaced with actual build)
- Complete source code
- Build scripts
- Testing framework
- Documentation
- Configuration files

To build the actual APK:
1. Follow the instructions in BUILD_INSTRUCTIONS.md
2. Use the build scripts:
   - build-apk.sh (Linux/Mac)
   - build-apk.bat (Windows)
3. Replace the placeholder APK with the built APK
4. Regenerate checksums

For testing instructions, see:
- APK_TESTING_PLAN.md
- POST_BUILD_TESTING_INSTRUCTIONS.md
EOF

# Create a zip file of the release
echo "Creating zip archive..."
ZIP_FILE="termux-crush-app-$VERSION-github-release.zip"
zip -r "$ZIP_FILE" "$TEMP_DIR"

# Clean up temporary directory
echo "Cleaning up temporary directory..."
rm -rf "$TEMP_DIR"

echo ""
echo "GitHub release package created: $ZIP_FILE"
echo ""
echo "To create the GitHub release:"
echo "1. Go to https://github.com/JlovesYouGit/termux-crush/releases"
echo "2. Click 'Draft a new release'"
echo "3. Set tag to $VERSION"
echo "4. Set title to 'Termux Crush App $VERSION'"
echo "5. Copy the contents of GITHUB_RELEASE_NOTES.md to the description"
echo "6. Upload the $ZIP_FILE file as an asset"
echo "7. If you have built the actual APK, also upload it as an asset"
echo "8. Click 'Publish release'"
echo ""
echo "IMPORTANT: The APK in this release is a placeholder."
echo "Someone with the Android development environment needs to:"
echo "1. Build the actual APK"
echo "2. Replace the placeholder APK"
echo "3. Update the release with the actual APK"