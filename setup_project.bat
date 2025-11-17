@echo off
echo Setting up Termux Crush Project...
echo.

REM Check if Android Studio is installed
where java >nul 2>&1
if %errorlevel% neq 0 (
    echo Warning: Java is not installed or not in PATH
    echo Please install Android Studio or Java Development Kit for full functionality
    echo.
    echo Android Studio download: https://developer.android.com/studio
    echo.
)

REM Check if Git is installed
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo Warning: Git is not installed
    echo Git is recommended for version control
    echo.
)

REM Display project structure
echo Project Structure:
echo =================
dir /A:D
echo.
echo Key Files:
echo =========
echo - app/                    - Main application module
echo - app/src/main/java/     - Kotlin source code
echo - app/src/main/res/      - Application resources
echo - build.gradle.kts       - Project build configuration
echo - app/build.gradle.kts   - App module build configuration
echo - README.md              - Project documentation
echo - BUILD_INSTRUCTIONS.md  - How to build the APK
echo.

echo Setup Information:
echo =================
echo To build the APK:
echo 1. Open Android Studio
echo 2. Select "Open an existing Android Studio project"
echo 3. Navigate to this folder and open it
echo 4. Wait for Gradle sync to complete
echo 5. Build ^> Build Bundle^(s^) ^/ APK^(s^) ^> Build APK
echo.
echo Alternative ^(Windows^):
echo Run build_apk.bat to build from command line
echo.
echo If you encounter Gradle wrapper issues:
echo Run fix_gradle_wrapper.bat to fix missing Gradle files
echo.
echo For detailed instructions, see BUILD_INSTRUCTIONS.md
echo.

pause