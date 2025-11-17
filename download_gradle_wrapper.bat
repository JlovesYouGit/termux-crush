@echo off
echo Downloading Gradle Wrapper JAR...
echo.

REM Create the gradle wrapper directory if it doesn't exist
if not exist gradle\wrapper mkdir gradle\wrapper

REM Try to download gradle-wrapper.jar from a reliable source
echo Attempting to download gradle-wrapper.jar from a reliable source...

REM Try JCenter (deprecated but some files still available)
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/org/gradle/gradle-wrapper/8.2/gradle-wrapper-8.2.jar' -OutFile 'gradle/wrapper/gradle-wrapper.jar'"

if exist gradle\wrapper\gradle-wrapper.jar (
    echo.
    echo SUCCESS: gradle-wrapper.jar has been downloaded successfully!
    echo.
    echo You can now build the APK using build_apk.bat
) else (
    echo.
    echo FAILED: Could not download gradle-wrapper.jar from Maven Central
    echo.
    echo Alternative solutions:
    echo ========================
    echo 1. Install Android Studio which includes Gradle
    echo 2. Download Gradle manually from https://gradle.org/releases/
    echo 3. If you have Gradle installed, run:
    echo    gradle wrapper --gradle-version 8.2
    echo 4. Or manually create the wrapper:
    echo    gradle wrapper
    echo.
    echo Manual installation steps:
    echo =========================
    echo 1. Download Gradle 8.2 from https://services.gradle.org/distributions/gradle-8.2-bin.zip
    echo 2. Extract the ZIP file
    echo 3. Find gradle-wrapper.jar in the lib directory
    echo 4. Copy it to gradle\wrapper\ in this project
    echo.
)

pause