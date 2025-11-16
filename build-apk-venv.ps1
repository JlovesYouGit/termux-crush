# PowerShell script to build APK in isolated environment with Android SDK
# This script sets up Android SDK and builds the Termux Crush App APK

Write-Host "Building Termux Crush App APK in isolated environment"
Write-Host "==================================================="

# Create build directory
$BuildDir = "$env:USERPROFILE\termux-crush-build-venv"
Write-Host "Creating build directory: $BuildDir"
if (-not (Test-Path $BuildDir)) {
    New-Item -ItemType Directory -Path $BuildDir | Out-Null
}
Set-Location $BuildDir

# Set up Android SDK in isolated environment
Write-Host "Setting up Android SDK..."
$SdkDir = "$BuildDir\android-sdk"
if (-not (Test-Path $SdkDir)) {
    New-Item -ItemType Directory -Path $SdkDir | Out-Null
}
Set-Location $SdkDir

# Download Android command line tools
if (-not (Test-Path "commandlinetools-win.zip")) {
    Write-Host "Downloading Android command line tools..."
    Invoke-WebRequest -Uri "https://dl.google.com/android/repository/commandlinetools-win-9477386_latest.zip" -OutFile "commandlinetools-win.zip"
}

# Extract tools
Write-Host "Extracting command line tools..."
if (-not (Test-Path "cmdline-tools")) {
    New-Item -ItemType Directory -Path "cmdline-tools" | Out-Null
}
Expand-Archive -Path "commandlinetools-win.zip" -DestinationPath "cmdline-tools" -Force
if (Test-Path "cmdline-tools\cmdline-tools") {
    Rename-Item -Path "cmdline-tools\cmdline-tools" -NewName "latest"
}

# Set up environment variables for this session
$env:ANDROID_HOME = $SdkDir
$env:ANDROID_SDK_ROOT = $SdkDir
$env:PATH = "$SdkDir\cmdline-tools\latest\bin;$SdkDir\platform-tools;$SdkDir\build-tools;$env:PATH"

Write-Host "Android SDK environment set up:"
Write-Host "  ANDROID_HOME: $env:ANDROID_HOME"

# Accept licenses (this might require manual interaction)
Write-Host "Accepting Android SDK licenses..."
Write-Host "This might require you to press 'y' multiple times to accept licenses"
cmdline-tools\latest\bin\sdkmanager --licenses

# Install essential SDK components
Write-Host "Installing essential SDK components..."
cmdline-tools\latest\bin\sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3"

Write-Host "Android SDK setup completed!"

# Go back to build directory
Set-Location $BuildDir

# Get the project directory
$ProjectDir = (Get-Item "$PSScriptRoot").FullName

# Clone repositories if they don't exist
Write-Host "Cloning repositories..."
if (-not (Test-Path "termux-app")) {
    git clone https://github.com/termux/termux-app
} else {
    Write-Host "termux-app already exists, pulling latest changes..."
    Set-Location termux-app
    git pull
    Set-Location ..
}

if (-not (Test-Path "termux-packages")) {
    git clone https://github.com/termux/termux-packages
} else {
    Write-Host "termux-packages already exists, pulling latest changes..."
    Set-Location termux-packages
    git pull
    Set-Location ..
}

# Copy our custom package
Write-Host "Setting up custom Crush package..."
Copy-Item -Path "$ProjectDir\crush-package" -Destination "termux-packages\packages\crush" -Recurse -Force

# Prepare build environment
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

# Check if Docker is available for package building
try {
    $DockerCheck = docker --version
    Write-Host "Docker found, building packages..."
    
    # For Docker on Windows, we need to use WSL or Docker Desktop
    Write-Host "Please start Docker Desktop and run the package building manually:"
    Write-Host "1. Open Docker Desktop"
    Write-Host "2. Run: docker run -it --rm -v ${PWD}:/root/termux-packages termux/package-builder bash"
    Write-Host "3. Inside the container, run:"
    Write-Host "   ./build-package.sh -a aarch64 git"
    Write-Host "   ./build-package.sh -a aarch64 golang"
    Write-Host "   ./build-package.sh -a aarch64 vim"
    Write-Host "   ./build-package.sh -a aarch64 neovim"
    Write-Host "   ./build-package.sh -a aarch64 crush"
    Write-Host "   ./scripts/build-bootstrap.sh --architectures aarch64,arm,i686,x86_64"
    Write-Host "   exit"
    Write-Host ""
    Write-Host "Press any key when you've completed the Docker steps..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
} catch {
    Write-Host "Docker not found. Please install Docker Desktop to build packages."
    Write-Host "Falling back to using pre-built bootstrap (if available)..."
}

# Copy bootstrap files to termux-app if they exist
$BootstrapFiles = Get-ChildItem "bootstrap-*.zip" -ErrorAction SilentlyContinue
if ($BootstrapFiles) {
    Write-Host "Copying bootstrap files..."
    Copy-Item "bootstrap-*.zip" -Destination "..\termux-app\app\src\main\cpp\" -ErrorAction SilentlyContinue
} else {
    Write-Host "No bootstrap files found. Building without pre-installed packages."
    Write-Host "The app will need to download packages on first run."
}

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
Write-Host "Building APK with isolated Android SDK..."
if (Test-Path "gradlew.bat") {
    # Use the isolated Android SDK
    $env:ANDROID_HOME = $SdkDir
    .\gradlew.bat assembleRelease
} else {
    Write-Host "gradlew.bat not found. Trying with system gradle..."
    $env:ANDROID_HOME = $SdkDir
    gradle assembleRelease
}

# Check if APK was built successfully
$ApkPath = "app\build\outputs\apk\release\app-release-unsigned.apk"
if (Test-Path $ApkPath) {
    Write-Host "APK built successfully!"
    Write-Host "Copying APK to project directory..."
    Copy-Item $ApkPath -Destination "$ProjectDir\termux-crush-app-venv-built.apk"
    Write-Host "APK saved as: $ProjectDir\termux-crush-app-venv-built.apk"
    
    # Also copy to a more standard name
    Copy-Item $ApkPath -Destination "$ProjectDir\termux-crush-app.apk"
    Write-Host "APK also saved as: $ProjectDir\termux-crush-app.apk"
} else {
    Write-Host "APK build failed. Check the build logs above for errors."
    Write-Host "The app might still be usable but without pre-installed packages."
    
    # Try to find any APK that was built
    $FoundApk = Get-ChildItem -Path "app\build\outputs\apk\*" -Filter "*.apk" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($FoundApk) {
        Write-Host "Found APK at: $($FoundApk.FullName)"
        Copy-Item $FoundApk.FullName -Destination "$ProjectDir\termux-crush-app-fallback.apk"
        Write-Host "Fallback APK saved as: $ProjectDir\termux-crush-app-fallback.apk"
    }
    
    exit 1
}

Write-Host ""
Write-Host "Build process completed in isolated environment!"
Write-Host "=============================================="
Write-Host "The APK has been built and saved as termux-crush-app.apk"
Write-Host "To install on an Android device:"
Write-Host "1. Transfer the APK to your device"
Write-Host "2. Enable 'Install unknown apps' in Settings"
Write-Host "3. Tap on the APK file to install"
Write-Host ""
Write-Host "Note: This is an unsigned APK. For production use, you should sign it with your own key."