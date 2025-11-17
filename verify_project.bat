@echo off
echo Verifying Termux Crush Project Structure...
echo.

set ERROR_COUNT=0
set WARNING_COUNT=0

echo Checking required files:
echo ======================

REM Check for main project files
if exist build.gradle.kts (
    echo [OK] build.gradle.kts
) else (
    echo [ERROR] build.gradle.kts not found
    set /a ERROR_COUNT+=1
)

if exist settings.gradle.kts (
    echo [OK] settings.gradle.kts
) else (
    echo [ERROR] settings.gradle.kts not found
    set /a ERROR_COUNT+=1
)

if exist gradle.properties (
    echo [OK] gradle.properties
) else (
    echo [ERROR] gradle.properties not found
    set /a ERROR_COUNT+=1
)

if exist gradlew.bat (
    echo [OK] gradlew.bat
) else (
    echo [ERROR] gradlew.bat not found
    set /a ERROR_COUNT+=1
)

if exist gradle\wrapper\gradle-wrapper.properties (
    echo [OK] gradle\wrapper\gradle-wrapper.properties
) else (
    echo [ERROR] gradle\wrapper\gradle-wrapper.properties not found
    set /a ERROR_COUNT+=1
)

if exist gradle\wrapper\gradle-wrapper.jar (
    echo [OK] gradle\wrapper\gradle-wrapper.jar
) else (
    echo [WARNING] gradle\wrapper\gradle-wrapper.jar not found ^(run download_gradle_wrapper.bat to fix^)
    set /a WARNING_COUNT+=1
)

REM Check for AndroidManifest
if exist app\src\main\AndroidManifest.xml (
    echo [OK] app\src\main\AndroidManifest.xml
) else (
    echo [ERROR] app\src\main\AndroidManifest.xml not found
    set /a ERROR_COUNT+=1
)

REM Check for main source files
if exist app\src\main\java\com\termux\crush\MainActivity.kt (
    echo [OK] app\src\main\java\com\termux\crush\MainActivity.kt
) else (
    echo [ERROR] app\src\main\java\com\termux\crush\MainActivity.kt not found
    set /a ERROR_COUNT+=1
)

if exist app\src\main\java\com\termux\crush\FirstFragment.kt (
    echo [OK] app\src\main\java\com\termux\crush\FirstFragment.kt
) else (
    echo [ERROR] app\src\main\java\com\termux\crush\FirstFragment.kt not found
    set /a ERROR_COUNT+=1
)

if exist app\src\main\java\com\termux\crush\RappedIntegration.kt (
    echo [OK] app\src\main\java\com\termux\crush\RappedIntegration.kt
) else (
    echo [ERROR] app\src\main\java\com\termux\crush\RappedIntegration.kt not found
    set /a ERROR_COUNT+=1
)

REM Check for layout files
if exist app\src\main\res\layout\activity_main.xml (
    echo [OK] app\src\main\res\layout\activity_main.xml
) else (
    echo [ERROR] app\src\main\res\layout\activity_main.xml not found
    set /a ERROR_COUNT+=1
)

if exist app\src\main\res\layout\content_main.xml (
    echo [OK] app\src\main\res\layout\content_main.xml
) else (
    echo [ERROR] app\src\main\res\layout\content_main.xml not found
    set /a ERROR_COUNT+=1
)

if exist app\src\main\res\layout\fragment_first.xml (
    echo [OK] app\src\main\res\layout\fragment_first.xml
) else (
    echo [ERROR] app\src\main\res\layout\fragment_first.xml not found
    set /a ERROR_COUNT+=1
)

REM Check for documentation files
if exist README.md (
    echo [OK] README.md
) else (
    echo [WARNING] README.md not found
    set /a WARNING_COUNT+=1
)

if exist EASY_BUILD_GUIDE.md (
    echo [OK] EASY_BUILD_GUIDE.md
) else (
    echo [WARNING] EASY_BUILD_GUIDE.md not found
    set /a WARNING_COUNT+=1
)

echo.
echo Verification complete.
echo ====================

if %ERROR_COUNT% equ 0 (
    echo [SUCCESS] All required files are present!
    if %WARNING_COUNT% gtr 0 (
        echo [WARNING] %WARNING_COUNT% warning(s) - see above
    )
    echo.
    echo You can now build the project using:
    echo 1. Android Studio ^(recommended^)
    echo 2. build_apk.bat ^(Windows command line^)
    echo.
    echo If you encounter Gradle wrapper issues, run download_gradle_wrapper.bat
) else (
    echo [%ERROR_COUNT% ERROR(S)] Some required files are missing.
    if %WARNING_COUNT% gtr 0 (
        echo [%WARNING_COUNT% WARNING(S)] Additional warnings - see above
    )
    echo.
    echo Please check the errors above and fix them before building.
    echo.
    echo Common fixes:
    echo - Run download_gradle_wrapper.bat to fix Gradle wrapper issues
    echo - Make sure you extracted all files from the project archive
    echo - Check that no antivirus software removed any files
)

echo.
echo For detailed build instructions, see EASY_BUILD_GUIDE.md
echo.
pause