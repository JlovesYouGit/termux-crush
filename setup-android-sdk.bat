@echo off
REM Script to set up Android SDK in an isolated environment (Windows)
REM This batch file downloads and configures Android SDK for building APKs

echo Setting up Android SDK in isolated environment
echo ============================================

REM Create isolated environment directory
set SDK_DIR=%USERPROFILE%\android-sdk-isolated
echo Creating isolated SDK directory: %SDK_DIR%
mkdir "%SDK_DIR%" 2>nul
cd /d "%SDK_DIR%"

REM Check if wget is available, if not, use PowerShell to download
where wget >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo wget not found, using PowerShell to download...
    powershell -Command "Invoke-WebRequest -Uri 'https://dl.google.com/android/repository/commandlinetools-win-9477386_latest.zip' -OutFile 'commandlinetools-win.zip'"
) else (
    echo Downloading Android command line tools with wget...
    wget https://dl.google.com/android/repository/commandlinetools-win-9477386_latest.zip -O commandlinetools-win.zip
)

REM Extract tools using PowerShell
echo Extracting command line tools...
powershell -Command "Expand-Archive -Path 'commandlinetools-win.zip' -DestinationPath 'cmdline-tools' -Force"
ren "cmdline-tools\cmdline-tools" "latest"

REM Set up environment variables for this session
set ANDROID_HOME=%SDK_DIR%
set ANDROID_SDK_ROOT=%SDK_DIR%
set PATH=%SDK_DIR%\cmdline-tools\latest\bin;%SDK_DIR%\platform-tools;%SDK_DIR%\build-tools;%PATH%

echo Android SDK environment set up:
echo   ANDROID_HOME: %ANDROID_HOME%
echo   SDK Tools: %SDK_DIR%\cmdline-tools\latest

REM Accept licenses (this might require manual interaction)
echo Accepting Android SDK licenses...
echo This might require you to press 'y' multiple times to accept licenses
cmdline-tools\latest\bin\sdkmanager --licenses

REM Install essential SDK components
echo Installing essential SDK components...
cmdline-tools\latest\bin\sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3"

echo.
echo Android SDK setup completed!
echo.
echo To use this SDK for building APKs:
echo 1. Set these environment variables in your build environment:
echo    ANDROID_HOME=%ANDROID_HOME%
echo    ANDROID_SDK_ROOT=%ANDROID_SDK_ROOT%
echo    PATH with Android tools added
echo.
echo The SDK is now ready for building Android APKs!
pause