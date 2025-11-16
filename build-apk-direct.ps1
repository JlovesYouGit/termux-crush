# PowerShell script to build the APK directly using installed Android SDK
# This script assumes Android SDK is already installed and configured

Write-Host "Building Termux Crush App APK directly"
Write-Host "===================================="

# Check if Android SDK is installed
$AndroidHome = $env:ANDROID_HOME
if (-not $AndroidHome) {
    $AndroidHome = $env:ANDROID_SDK_ROOT
}

if (-not $AndroidHome -or -not (Test-Path $AndroidHome)) {
    Write-Host "Error: Android SDK not found. Please install Android Studio or set ANDROID_HOME environment variable."
    Write-Host "Download Android Studio from: https://developer.android.com/studio"
    exit 1
}

Write-Host "Using Android SDK at: $AndroidHome"

# Check if Git is installed
try {
    $GitVersion = git --version
    Write-Host "Git found: $GitVersion"
} catch {
    Write-Host "Error: Git is not installed. Please install Git."
    Write-Host "Download Git from: https://git-scm.com/download/win"
    exit 1
}

# Check if Docker is installed
try {
    $DockerVersion = docker --version
    Write-Host "Docker found: $DockerVersion"
} catch {
    Write-Host "Error: Docker is not installed. Please install Docker Desktop."
    Write-Host "Download Docker Desktop from: https://www.docker.com/products/docker-desktop"
    exit 1
}

# Get the current directory
$ProjectDir = Get-Location
Write-Host "Project directory: $ProjectDir"

# Create build directory
$BuildDir = "$ProjectDir\build"
if (-not (Test-Path $BuildDir)) {
    New-Item -ItemType Directory -Path $BuildDir | Out-Null
}
Set-Location $BuildDir

# Clone repositories if they don't exist
if (-not (Test-Path "termux-app")) {
    Write-Host "Cloning termux-app repository..."
    git clone https://github.com/termux/termux-app
} else {
    Write-Host "Updating termux-app repository..."
    Set-Location termux-app
    git pull
    Set-Location ..
}

if (-not (Test-Path "termux-packages")) {
    Write-Host "Cloning termux-packages repository..."
    git clone https://github.com/termux/termux-packages
} else {
    Write-Host "Updating termux-packages repository..."
    Set-Location termux-packages
    git pull
    Set-Location ..
}

# Copy our custom package
Write-Host "Setting up custom Crush package..."
Copy-Item -Path "$ProjectDir\crush-package" -Destination "termux-packages\packages\crush" -Recurse -Force

# Set up build environment
Set-Location termux-packages

# Download build-bootstrap.sh if it doesn't exist
if (-not (Test-Path "scripts\build-bootstrap.sh")) {
    Write-Host "Downloading build-bootstrap.sh script..."
    Invoke-WebRequest -Uri "https://gist.github.com/seeya/a9ce074cf560aa7113043859360b7bfc/raw/206b5f4755b65569cf4af8d92b2481258c134b74/build-bootstrap.sh" -OutFile "scripts\build-bootstrap.sh"
}

# Update properties.sh
Write-Host "Updating properties.sh..."
$PropertiesContent = Get-Content "scripts\properties.sh"
$PropertiesContent = $PropertiesContent -replace 'TERMUX_APP_PACKAGE=.*', 'TERMUX_APP_PACKAGE="com.termux.crush"'
Set-Content -Path "scripts\properties.sh" -Value $PropertiesContent

# Build packages using Docker (this requires user interaction)
Write-Host "Starting Docker container for package building..."
Write-Host "Inside the Docker container, please run:"
Write-Host "  ./build-package.sh -a aarch64 git"
Write-Host "  ./build-package.sh -a aarch64 golang"
Write-Host "  ./build-package.sh -a aarch64 vim"
Write-Host "  ./build-package.sh -a aarch64 neovim"
Write-Host "  ./build-package.sh -a aarch64 crush"
Write-Host "  ./scripts/build-bootstrap.sh --architectures aarch64,arm,i686,x86_64"
Write-Host "  exit"
Write-Host ""
Write-Host "Press any key to start the Docker container..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# Start Docker container
docker run -it --rm -v ${PWD}:/root/termux-packages termux/package-builder bash

# Copy bootstrap files to termux-app
Write-Host "Copying bootstrap files..."
Copy-Item "bootstrap-*.zip" -Destination "..\termux-app\app\src\main\cpp\" -ErrorAction SilentlyContinue

# Modify termux-app for our package
Set-Location "..\termux-app"

# Update package name in build.gradle
Write-Host "Updating package name in build.gradle..."
$BuildGradleContent = Get-Content "app\build.gradle"
$BuildGradleContent = $BuildGradleContent -replace 'com\.termux', 'com.termux.crush'
Set-Content -Path "app\build.gradle" -Value $BuildGradleContent

# Comment out downloadBootstrap task
Write-Host "Modifying build.gradle to skip official bootstrap download..."
$BuildGradleContent = Get-Content "app\build.gradle"
$ModifiedContent = @()
$InDownloadBootstrapsTask = $false

foreach ($line in $BuildGradleContent) {
    if ($line -match 'task downloadBootstraps') {
        $InDownloadBootstrapsTask = $true
        $ModifiedContent += "//$line"
    } elseif ($InDownloadBootstrapsTask) {
        $ModifiedContent += "//$line"
        if ($line -match '}') {
            $InDownloadBootstrapsTask = $false
        }
    } else {
        $ModifiedContent += $line
    }
}
Set-Content -Path "app\build.gradle" -Value $ModifiedContent

# Build APK using Gradle
Write-Host "Building APK..."
if (Test-Path "gradlew.bat") {
    .\gradlew.bat assembleRelease
} else {
    Write-Host "gradlew.bat not found, trying with system gradle..."
    gradle assembleRelease
}

# Check if APK was built successfully
$ApkPath = "app\build\outputs\apk\release\app-release-unsigned.apk"
if (Test-Path $ApkPath) {
    Write-Host "APK built successfully!"
    Write-Host "Copying APK to project directory..."
    Copy-Item $ApkPath -Destination "$ProjectDir\termux-crush-app-built.apk"
    Write-Host "APK saved as: $ProjectDir\termux-crush-app-built.apk"
} else {
    Write-Host "APK build failed. Check the build logs above for errors."
    exit 1
}

Write-Host ""
Write-Host "Build process completed!"
Write-Host "======================"
Write-Host "The APK has been built and saved as termux-crush-app-built.apk"
Write-Host "To install on an Android device:"
Write-Host "1. Transfer the APK to your device"
Write-Host "2. Enable 'Install unknown apps' in Settings"
Write-Host "3. Tap on the APK file to install"
Write-Host ""
Write-Host "Note: This is an unsigned APK. For production use, you should sign it with your own key."