# Easy Build Guide for Termux Crush App

This guide provides the simplest way to build the Termux Crush APK without dealing with Gradle wrapper issues.

## Option 1: Use Android Studio (Recommended)

This is the easiest and most reliable method:

1. **Download and Install Android Studio**
   - Go to https://developer.android.com/studio
   - Download Android Studio
   - Install it following the installation wizard

2. **Open the Project**
   - Launch Android Studio
   - Select "Open an existing Android Studio project"
   - Navigate to the TermuxCrushApp folder
   - Click "OK"

3. **Let Android Studio Handle Everything**
   - Android Studio will automatically download and configure Gradle
   - Wait for the sync to complete (this may take a few minutes)
   - If prompted, allow Android Studio to install any missing components

4. **Build the APK**
   - In the menu, select **Build** → **Build Bundle(s) / APK(s)** → **Build APK**
   - Wait for the build to complete
   - When finished, click "locate" in the notification to find your APK

## Option 2: Manual Gradle Installation

If you prefer not to use Android Studio:

1. **Download Gradle Manually**
   - Go to https://gradle.org/releases/
   - Download Gradle 8.2 (binary distribution)
   - Extract it to a folder (e.g., `C:\gradle`)

2. **Add Gradle to Your PATH**
   - Open System Properties → Advanced → Environment Variables
   - In System Variables, find and select "Path", then click "Edit"
   - Click "New" and add the path to Gradle's bin directory:
     `C:\gradle\gradle-8.2\bin`
   - Click OK to save

3. **Open Command Prompt as Administrator**
   - Press Win+R, type `cmd`, press Ctrl+Shift+Enter

4. **Navigate to the Project Directory**
   ```cmd
   cd C:\Users\JJ\Downloads\lest\TermuxCrushApp
   ```

5. **Generate the Gradle Wrapper**
   ```cmd
   gradle wrapper --gradle-version 8.2
   ```

6. **Build the APK**
   ```cmd
   gradlew.bat assembleDebug
   ```

## Option 3: Use Pre-built APK

If you just want to test the app:

1. Check the Releases section of the GitHub repository (if available)
2. Download a pre-built APK
3. Transfer it to your Android device
4. Install it (you may need to enable "Install from unknown sources")

## Troubleshooting Common Issues

### Issue: "JAVA_HOME is not set"
**Solution:**
1. Find your Java installation (usually in Android Studio's jre folder)
2. Set JAVA_HOME environment variable:
   - Open System Properties → Advanced → Environment Variables
   - Under System Variables, click "New"
   - Variable name: `JAVA_HOME`
   - Variable value: Path to your Java installation (e.g., `C:\Program Files\Android\Android Studio\jre`)
   - Click OK

### Issue: "SDK location not found"
**Solution:**
1. Create a `local.properties` file in the project root
2. Add your SDK path:
   ```
   sdk.dir=C\:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk
   ```
   (Replace `YourUsername` with your actual Windows username)

### Issue: "Could not find tools.jar"
**Solution:**
1. This usually means you're using JRE instead of JDK
2. Install Android Studio which includes the full JDK
3. Or download and install JDK separately from Oracle or OpenJDK

## Installing the APK on Your Android Device

1. **Enable Developer Options**
   - Go to Settings → About phone
   - Tap "Build number" 7 times
   - Go back to Settings → Developer options
   - Enable "USB debugging"

2. **Connect Your Device**
   - Connect your Android device to your computer via USB
   - Allow USB debugging when prompted on your device

3. **Install the APK**
   ```cmd
   adb install app\build\outputs\apk\debug\app-debug.apk
   ```

## Alternative: Manual Installation

1. Transfer the APK to your Android device (via email, cloud storage, etc.)
2. Open the file manager on your Android device
3. Navigate to the APK file
4. Tap it to install
5. Allow installation from unknown sources if prompted

## Getting Help

If you're still having issues:

1. Check our [Troubleshooting Guide](TROUBLESHOOTING.md)
2. Create an issue on the GitHub repository
3. Contact the development team

This guide should help you build and install the Termux Crush APK with minimal complications.