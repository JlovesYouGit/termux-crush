@echo off
echo Fixing Gradle Wrapper for Termux Crush...
echo.

REM Check if we have Java installed
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

echo Java version:
java -version
echo.

REM Create the gradle wrapper directory if it doesn't exist
if not exist gradle\wrapper mkdir gradle\wrapper

echo Downloading Gradle Wrapper JAR file...
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://repo.gradle.org/gradle/libs-releases/org/gradle/gradle-wrapper/8.2/gradle-wrapper-8.2.jar' -OutFile 'gradle/wrapper/gradle-wrapper.jar'"

if exist gradle\wrapper\gradle-wrapper.jar (
    echo Successfully downloaded gradle-wrapper.jar
) else (
    echo Failed to download gradle-wrapper.jar
    echo.
    echo Alternative solutions:
    echo ========================
    echo 1. Install Android Studio ^(which includes Gradle^)
    echo 2. Install Gradle manually from https://gradle.org/releases/
    echo 3. Or generate the wrapper using an existing Gradle installation:
    echo    gradle wrapper --gradle-version 8.2
    echo.
    pause
    exit /b 1
)

echo.
echo Fixing gradlew permissions...
if exist gradlew (
    attrib -R gradlew >nul 2>&1
    echo Fixed gradlew permissions
)

echo.
echo Gradle Wrapper has been fixed!
echo You can now try building the APK again using build_apk.bat
echo.
echo If you still encounter issues, try:
echo 1. Opening the project in Android Studio
echo 2. Letting Android Studio sync and fix any remaining issues
echo.
pause