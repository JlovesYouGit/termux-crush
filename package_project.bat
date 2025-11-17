@echo off
echo Packaging Termux Crush Project...
echo.

REM Create a timestamp for the package
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

REM Create package directory
set "package_dir=termux-crush-package-%datestamp%"
mkdir "%package_dir%"

REM Copy project files
echo Copying project files...
xcopy /E /I /EXCLUDE:package_exclude.txt . "%package_dir%"

REM Create zip archive
echo Creating zip archive...
powershell -command "Compress-Archive -Path '%package_dir%' -DestinationPath '%package_dir%.zip'"

REM Clean up
rmdir /S /Q "%package_dir%"

echo.
echo Project packaged successfully as %package_dir%.zip
echo.
pause