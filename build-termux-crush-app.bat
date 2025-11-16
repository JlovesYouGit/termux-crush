@echo off
REM Script to build custom Termux app with Crush pre-installed
REM This script provides guidance for building the custom APK

echo Building Termux Crush App
echo ========================

echo Checking prerequisites...

where git >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: git is not installed
    exit /b 1
)

where docker >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: docker is not installed
    exit /b 1
)

echo All prerequisites found.

set WORK_DIR=%USERPROFILE%\termux-crush-build
echo Creating working directory: %WORK_DIR%
mkdir "%WORK_DIR%" 2>nul
cd /d "%WORK_DIR%"

echo Cloning repositories...
if not exist "termux-app" (
    git clone https://github.com/termux/termux-app
) else (
    echo termux-app already exists, pulling latest changes...
    cd termux-app && git pull && cd ..
)

if not exist "termux-packages" (
    git clone https://github.com/termux/termux-packages
) else (
    echo termux-packages already exists, pulling latest changes...
    cd termux-packages && git pull && cd ..
)

echo Setting up custom package...
REM Copy crush package definition
xcopy /E /I ..\crush-package termux-packages\packages\crush

echo Setup complete!
echo.
echo Next steps:
echo 1. cd termux-packages
echo 2. scripts\run-docker.sh
echo 3. Inside Docker container:
echo    - build-package.sh -a aarch64 git
echo    - build-package.sh -a aarch64 golang
echo    - build-package.sh -a aarch64 vim
echo    - build-package.sh -a aarch64 crush
echo    - scripts\build-bootstrap.sh --architectures aarch64,arm,i686,x86_64
echo 4. Copy bootstrap files to termux-app\app\src\main\cpp\
echo 5. Build APK in Android Studio

echo.
echo For detailed instructions, see BUILD_INSTRUCTIONS.md