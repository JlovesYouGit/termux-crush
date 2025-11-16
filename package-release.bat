@echo off
REM Script to package a complete release with the built APK (Windows wrapper)
REM This batch file provides instructions for packaging the release on Windows

echo Termux Crush App Release Packaging
echo ===================================
echo.
echo This script provides guidance for packaging the release on Windows.
echo.
echo Prerequisites:
echo 1. PowerShell or Git Bash
echo 2. zip utility (available in Git for Windows)
echo.
echo Packaging Process:
echo 1. Open Git Bash or PowerShell
echo 2. Navigate to this directory
echo 3. Run the packaging script: bash package-release.sh
echo.
echo What the packaging script does:
echo 1. Checks for the built APK file
echo 2. Generates checksums if APK exists
echo 3. Creates a complete package directory with all files
echo 4. Creates a zip archive of the complete package
echo.
echo The complete package will include:
echo - APK file (if built)
echo - All source code
echo - Build scripts
echo - Testing framework
echo - Documentation
echo - Configuration files
echo.
pause