# Troubleshooting Guide for Termux Crush App

This document provides solutions for common issues encountered when building and using the Termux Crush Android application.

## Common Build Issues

### 1. Gradle Wrapper Issues

**Error Message:**
```
Error: Could not find or load main class org.gradle.wrapper.GradleWrapperMain
Caused by: java.lang.ClassNotFoundException: org.gradle.wrapper.GradleWrapperMain
```

**Solution:**
1. Run [fix_gradle_wrapper.bat](file://c:\Users\JJ\Downloads\lest\TermuxCrushApp\fix_gradle_wrapper.bat) to automatically download the missing Gradle wrapper JAR
2. If that doesn't work, manually install Android Studio which includes Gradle
3. Or install Gradle manually and regenerate the wrapper:
   ```cmd
   gradle wrapper --gradle-version 8.2
   ```

### 2. Java Not Found

**Error Message:**
```
Error: Java is not installed or not in PATH
```

**Solution:**
1. Download and install Android Studio from https://developer.android.com/studio
2. During installation, ensure the Android SDK and JDK components are selected
3. Add Java to your PATH environment variable:
   - Find your Java installation directory (usually in Android Studio's jre folder)
   - Add it to your PATH environment variable

### 3. SDK Location Not Found

**Error Message:**
```
SDK location not found
```

**Solution:**
1. Create a `local.properties` file in the project root directory
2. Add your SDK path:
   ```
   sdk.dir=C\:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk
   ```
3. Replace `YourUsername` with your actual Windows username

### 4. Dependency Download Issues

**Symptoms:**
- Long build times
- Connection timeouts
- Failed dependency resolution

**Solutions:**
1. Ensure you have a stable internet connection
2. Try building again (some downloads may have been interrupted)
3. Configure Gradle to use a proxy if you're behind a corporate firewall:
   - Create or edit `gradle.properties` in your user directory:
     ```
     systemProp.http.proxyHost=proxy.company.com
     systemProp.http.proxyPort=8080
     systemProp.https.proxyHost=proxy.company.com
     systemProp.https.proxyPort=8080
     ```

## Runtime Issues

### 1. App Crashes on Startup

**Possible Causes:**
1. Missing permissions
2. Incompatible Android version
3. Corrupted installation

**Solutions:**
1. Ensure your device is running Android 5.0 (API level 21) or higher
2. Uninstall and reinstall the app
3. Check logcat output for specific error messages:
   ```cmd
   adb logcat -s "TermuxCrush"
   ```

### 2. Rapped Integration Not Working

**Symptoms:**
- "Rapped is not installed" message even though it is installed
- Commands not executing in Termux

**Solutions:**
1. Ensure both apps are installed from the same source (both from APK or both from Play Store)
2. Check that Rapped has the necessary permissions
3. Restart both applications
4. Update both apps to the latest versions

### 3. Copy Function Not Working

**Symptoms:**
- "Copied to clipboard" message but clipboard content unchanged

**Solutions:**
1. Check if another app is interfering with clipboard access
2. Restart your device
3. Ensure the app has clipboard access permissions

## Development Environment Issues

### 1. Android Studio Sync Failed

**Solutions:**
1. Check your internet connection
2. Ensure Android Studio is updated to the latest version
3. Try **File** → **Sync Project with Gradle Files**
4. Invalidate caches and restart: **File** → **Invalidate Caches and Restart**

### 2. Slow Build Times

**Solutions:**
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
4. Increase Gradle memory in `gradle.properties`:
   ```
   org.gradle.jvmargs=-Xmx2048m
   ```

## Testing Issues

### 1. Unit Tests Failing

**Common Causes:**
1. Missing test dependencies
2. Incorrect mock setup
3. Environment-specific issues

**Solutions:**
1. Ensure all test dependencies are properly declared in `app/build.gradle.kts`
2. Check that Mockito and other test libraries are correctly configured
3. Run tests in isolation to identify specific failures

## Deployment Issues

### 1. Installation Failed

**Error Messages:**
- "App not installed"
- "Parse error"
- "Installation failed"

**Solutions:**
1. Ensure the APK is not corrupted by rebuilding it
2. Check that your device allows installation from unknown sources
3. Ensure sufficient storage space is available
4. Uninstall any previous versions of the app

### 2. Release Build Issues

**Problems:**
- Signing errors
- ProGuard issues
- Missing resources

**Solutions:**
1. Verify your keystore file is valid and accessible
2. Check that all signing configuration parameters are correct
3. Review ProGuard rules in `app/proguard-rules.pro`
4. Ensure all resources are properly referenced

## Performance Optimization

### 1. App Size Reduction
1. Enable resource shrinking in `app/build.gradle.kts`:
   ```kotlin
   buildTypes {
       release {
           isShrinkResources = true
           isMinifyEnabled = true
       }
   }
   ```

### 2. Startup Time Improvement
1. Use lazy initialization for non-essential components
2. Optimize the main activity's onCreate method
3. Defer non-critical operations

## Additional Resources

### Useful Commands

1. **Clean and rebuild:**
   ```cmd
   gradlew.bat clean build
   ```

2. **Run unit tests:**
   ```cmd
   gradlew.bat test
   ```

3. **Check dependencies:**
   ```cmd
   gradlew.bat dependencies
   ```

4. **View build environment:**
   ```cmd
   gradlew.bat properties
   ```

### Helpful Links

1. [Android Developer Documentation](https://developer.android.com/docs)
2. [Gradle User Guide](https://docs.gradle.org/current/userguide/userguide.html)
3. [Kotlin Documentation](https://kotlinlang.org/docs/home.html)
4. [Material Design Guidelines](https://material.io/develop/android)

## Getting Help

If you're still experiencing issues after trying these solutions:

1. Check the project's GitHub issues page
2. Create a detailed issue report including:
   - Error messages
   - Steps to reproduce
   - Your development environment details
   - Android Studio/Gradle versions
3. Include relevant log output if applicable

This troubleshooting guide should help you resolve most common issues with the Termux Crush application.