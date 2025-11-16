# PowerShell script to prepare a GitHub release package
# This script creates a package that can be uploaded to GitHub releases

Write-Host "Preparing GitHub Release Package"
Write-Host "==============================="

# Define version
$VERSION = "v1.0.0"
$RELEASE_DATE = Get-Date -Format "yyyy-MM-dd"

Write-Host "Creating release package for version $VERSION..."

# Create a temporary directory for the release
$TEMP_DIR = "temp-release-$VERSION"
Write-Host "Creating temporary directory: $TEMP_DIR"
New-Item -ItemType Directory -Path $TEMP_DIR -Force | Out-Null

# Copy all necessary files to the release directory
Write-Host "Copying files to release directory..."

# Copy documentation
Copy-Item "README.md" -Destination $TEMP_DIR
Copy-Item "USER_GUIDE.md" -Destination $TEMP_DIR
Copy-Item "BUILD_INSTRUCTIONS.md" -Destination $TEMP_DIR
Copy-Item "DEPLOYMENT_INSTRUCTIONS.md" -Destination $TEMP_DIR
Copy-Item "GITHUB_RELEASE_NOTES.md" -Destination "$TEMP_DIR/RELEASE_NOTES.md"

# Copy testing documentation
Copy-Item "APK_TESTING_PLAN.md" -Destination $TEMP_DIR
Copy-Item "APK_TESTING_README.md" -Destination $TEMP_DIR
Copy-Item "APK_TESTING_REPORT_TEMPLATE.md" -Destination $TEMP_DIR
Copy-Item "APK_TESTING_SUMMARY.md" -Destination $TEMP_DIR
Copy-Item "APK_TEST_EXECUTION_GUIDE.md" -Destination $TEMP_DIR
Copy-Item "POST_BUILD_TESTING_INSTRUCTIONS.md" -Destination $TEMP_DIR

# Copy build scripts
Copy-Item "build-apk.sh" -Destination $TEMP_DIR
Copy-Item "build-apk.bat" -Destination $TEMP_DIR
Copy-Item "build-termux-crush-app.sh" -Destination $TEMP_DIR
Copy-Item "build-termux-crush-app.bat" -Destination $TEMP_DIR
Copy-Item "package-release.sh" -Destination $TEMP_DIR
Copy-Item "package-release.bat" -Destination $TEMP_DIR

# Copy configuration files
Copy-Item "manifest.json" -Destination $TEMP_DIR
Copy-Item "config" -Destination $TEMP_DIR -Recurse

# Copy package definition
Copy-Item "crush-package" -Destination $TEMP_DIR -Recurse

# Copy scripts
Copy-Item "scripts" -Destination $TEMP_DIR -Recurse

# Copy the APK (placeholder for now)
Copy-Item "releases\v1.0.0\termux-crush-app-$VERSION.apk" -Destination $TEMP_DIR

# Copy checksums if they exist, otherwise create a placeholder
if (Test-Path "releases\v1.0.0\CHECKSUMS.txt") {
    Copy-Item "releases\v1.0.0\CHECKSUMS.txt" -Destination $TEMP_DIR
} else {
    $CHECKSUM_CONTENT = @"
# Checksums for Termux Crush App $VERSION
# This file will contain checksums for the APK once it is built

# Format:
# <algorithm>:<checksum> <filename>

# To generate checksums after building the APK:
# sha256sum termux-crush-app-$VERSION.apk > CHECKSUMS.txt
# md5sum termux-crush-app-$VERSION.apk >> CHECKSUMS.txt
"@
    Set-Content -Path "$TEMP_DIR\CHECKSUMS.txt" -Value $CHECKSUM_CONTENT
}

# Create a release info file
$RELEASE_INFO_CONTENT = @"
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
"@
Set-Content -Path "$TEMP_DIR\RELEASE_INFO.txt" -Value $RELEASE_INFO_CONTENT

# Create a zip file of the release
Write-Host "Creating zip archive..."
$ZIP_FILE = "termux-crush-app-$VERSION-github-release.zip"
Compress-Archive -Path $TEMP_DIR -DestinationPath $ZIP_FILE -Force

# Clean up temporary directory
Write-Host "Cleaning up temporary directory..."
Remove-Item -Path $TEMP_DIR -Recurse -Force

Write-Host ""
Write-Host "GitHub release package created: $ZIP_FILE"
Write-Host ""
Write-Host "To create the GitHub release:"
Write-Host "1. Go to https://github.com/JlovesYouGit/termux-crush/releases"
Write-Host "2. Click 'Draft a new release'"
Write-Host "3. Set tag to $VERSION"
Write-Host "4. Set title to 'Termux Crush App $VERSION'"
Write-Host "5. Copy the contents of GITHUB_RELEASE_NOTES.md to the description"
Write-Host "6. Upload the $ZIP_FILE file as an asset"
Write-Host "7. If you have built the actual APK, also upload it as an asset"
Write-Host "8. Click 'Publish release'"
Write-Host ""
Write-Host "IMPORTANT: The APK in this release is a placeholder."
Write-Host "Someone with the Android development environment needs to:"
Write-Host "1. Build the actual APK"
Write-Host "2. Replace the placeholder APK"
Write-Host "3. Update the release with the actual APK"