@echo off
echo Building Termux Crush APK...
echo.

REM Check if Android Studio is installed
where java >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Java is not installed or not in PATH
    echo Please install Android Studio or Java Development Kit
    echo.
    echo Android Studio download: https://developer.android.com/studio
    echo.
    pause
    exit /b 1
)

REM Check if gradle wrapper JAR exists
if not exist gradle\wrapper\gradle-wrapper.jar (
    echo Error: Gradle wrapper JAR not found
    echo.
    echo Running fix_gradle_wrapper.bat to fix this issue...
    call fix_gradle_wrapper.bat
    echo.
    echo After fixing the Gradle wrapper, please run this script again
    pause
    exit /b 1
)

REM Check if gradlew exists
if not exist gradlew.bat (
    echo Error: gradlew.bat not found
    echo Please run this script from the project root directory
    pause
    exit /b 1
)

REM Make gradlew executable
attrib -R gradlew.bat >nul 2>&1

REM Build the APK
echo Building APK...
echo This may take several minutes for the first build...
echo.
call gradlew.bat assembleDebug

if %errorlevel% equ 0 (
    echo.
    echo ==========================================
    echo APK built successfully!
    echo ==========================================
    echo You can find it at: app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo To install on your device:
    echo 1. Enable Developer Options and USB Debugging on your Android device
    echo 2. Connect your device via USB
    echo 3. Run: adb install app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo Or transfer the APK to your device and install it manually
) else (
    echo.
    echo ==========================================
    echo Error building APK
    echo ==========================================
    echo Please check the error messages above.
    echo.
    echo Common solutions:
    echo 1. Make sure you have internet connection ^(for downloading dependencies^)
    echo 2. Try opening the project in Android Studio to resolve issues
    echo 3. Check if your SDK paths are correctly configured
    echo 4. Run fix_gradle_wrapper.bat if the Gradle wrapper is corrupted
)

pause