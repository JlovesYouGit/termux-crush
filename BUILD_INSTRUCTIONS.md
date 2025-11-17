# Build Instructions for Termux Crush App

This document provides detailed instructions on how to build the Termux Crush APK from source code.

## Prerequisites

### Required Software
1. **Android Studio** (Android Studio Electric Eel 2022.1.1 or later recommended)
2. **JDK 8 or higher** (usually included with Android Studio)
3. **Git** (for version control, optional but recommended)

### System Requirements
- Windows 10/11, macOS 10.14+, or Linux
- At least 8GB RAM (16GB recommended)
- 4GB available disk space
- 2GB available disk space for Android Studio

## Method 1: Building with Android Studio (Recommended)

### Step 1: Import the Project
1. Open Android Studio
2. Select "Open an existing Android Studio project"
3. Navigate to the TermuxCrushApp directory
4. Select the folder and click "OK"

### Step 2: Wait for Gradle Sync
1. Android Studio will automatically sync the project
2. Wait for the sync to complete (this may take a few minutes)
3. Resolve any issues if prompted

### Step 3: Build the APK
1. In the menu bar, select **Build** → **Build Bundle(s) / APK(s)** → **Build APK**
2. Wait for the build process to complete
3. When finished, you'll see a notification "Build successful"

### Step 4: Locate the APK
1. Click the "locate" link in the notification, or
2. Navigate to: `app/build/outputs/apk/debug/app-debug.apk`

## Method 2: Building with Command Line (Windows)

### Step 1: Open Command Prompt
1. Navigate to the project root directory (TermuxCrushApp)
2. Ensure `gradlew.bat` is present in the directory

### Step 2: Run the Build Command
```cmd
gradlew.bat assembleDebug
```

### Step 3: Locate the APK
The APK will be generated at:
```
app\build\outputs\apk\debug\app-debug.apk
```

## Method 3: Using the Provided Batch Script (Windows)

### Step 1: Run the Build Script
1. Navigate to the project root directory
2. Double-click `build_apk.bat` or run it from command prompt:
```cmd
build_apk.bat
```

### Step 2: Locate the APK
The script will display the location of the generated APK when complete.

## Building a Release Version

To build a release version suitable for distribution:

### Step 1: Generate a Signed APK
1. In Android Studio, select **Build** → **Generate Signed Bundle / APK**
2. Select **APK** and click **Next**
3. Create a new keystore or use an existing one
4. Fill in the required information:
   - Key store path
   - Key store password
   - Key alias
   - Key password
5. Select **release** as the build type
6. Click **Finish**

### Step 2: Locate the Release APK
The release APK will be generated at:
```
app/build/outputs/apk/release/app-release.apk
```

## Troubleshooting Common Issues

### Issue: "Gradle sync failed"
**Solution:**
1. Check your internet connection
2. Ensure Android Studio is updated to the latest version
3. Try **File** → **Sync Project with Gradle Files**

### Issue: "SDK location not found"
**Solution:**
1. Create a `local.properties` file in the project root
2. Add the SDK path: `sdk.dir=C\:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk`

### Issue: "Unable to access Android SDK add-on list"
**Solution:**
1. Go to **File** → **Settings** → **Appearance & Behavior** → **System Settings** → **Android SDK**
2. Download the required SDK platforms

### Issue: "Could not find tools.jar"
**Solution:**
1. Ensure JDK is installed
2. Set the JAVA_HOME environment variable to point to your JDK installation

## Installing the APK on Android Device

### Method 1: USB Debugging
1. Enable Developer Options on your Android device
2. Enable USB Debugging
3. Connect your device to your computer via USB
4. Run in terminal: `adb install app-debug.apk`

### Method 2: Manual Transfer
1. Copy the APK file to your Android device (via USB, email, cloud storage, etc.)
2. Open the file manager on your Android device
3. Navigate to the APK file location
4. Tap the APK file to install
5. Allow installation from unknown sources if prompted

## Testing the Application

### Basic Functionality Test
1. Launch the Termux Crush app
2. Enter a sample question in the input field
3. Tap "Ask Crush" and verify a response appears
4. Tap "Copy" and verify the content is copied to clipboard
5. Tap "Run in Termux" and verify the integration works (if Rapped is installed)

### Integration Test with Rapped
1. Install Rapped on your device (if not already installed)
2. Run a command using the "Run in Termux" button
3. Verify that Rapped opens and executes the command

## Customization Options

### Changing the App Name
1. Edit `app/src/main/res/values/strings.xml`
2. Modify the `app_name` string value

### Changing the Package Name
1. Edit `app/build.gradle.kts`
2. Modify the `applicationId` value
3. Update package declarations in Kotlin files

### Adding New Features
1. Create new fragments in `app/src/main/java/com/termux/crush/`
2. Add layouts in `app/src/main/res/layout/`
3. Update navigation in `app/src/main/res/navigation/nav_graph.xml`

## Performance Considerations

### Optimizing Build Times
1. Enable Gradle daemon in `gradle.properties`:
   ```
   org.gradle.daemon=true
   ```
2. Enable parallel builds:
   ```
   org.gradle.parallel=true
   ```
3. Enable build caching:
   ```
   org.gradle.caching=true
   ```

## Next Steps

1. **Test the application** thoroughly on different Android devices
2. **Add real AI integration** by connecting to AI services
3. **Enhance the UI** with additional features and customization options
4. **Implement release signing** for distribution
5. **Set up continuous integration** with GitHub Actions

This concludes the build instructions for the Termux Crush App. The application is ready to build and use as an APK that works with Rapped for Termux integration.