#!/bin/bash
# Script to create a minimal placeholder APK for GitHub release
# This creates a basic APK that can be replaced with the actual build

echo "Creating placeholder APK for GitHub release"
echo "========================================"

# Create a temporary directory for the minimal Android project
TEMP_DIR="/tmp/termux-crush-placeholder"
echo "Creating temporary project directory: $TEMP_DIR"
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

# Create basic Android project structure
mkdir -p app/src/main/{java,res} app/src/main/res/values
mkdir -p app/libs

# Create AndroidManifest.xml
cat > app/src/main/AndroidManifest.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.termux.crush"
    android:versionCode="1"
    android:versionName="1.0.0">

    <uses-sdk android:minSdkVersion="21" android:targetSdkVersion="30" />

    <application
        android:allowBackup="true"
        android:label="Termux Crush App"
        android:theme="@android:style/Theme.DeviceDefault">
        
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
EOF

# Create a minimal MainActivity.java
mkdir -p app/src/main/java/com/termux/crush
cat > app/src/main/java/com/termux/crush/MainActivity.java << 'EOF'
package com.termux.crush;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        TextView textView = new TextView(this);
        textView.setText("Termux Crush App Placeholder\n\n" +
                        "This is a placeholder APK for the Termux Crush App release.\n" +
                        "The actual APK needs to be built by someone with the Android development environment.\n\n" +
                        "To build the actual APK:\n" +
                        "1. Clone the repository\n" +
                        "2. Follow BUILD_INSTRUCTIONS.md\n" +
                        "3. Use the build scripts in the termux-crush-app directory\n" +
                        "4. Replace this placeholder with the built APK");
        
        setContentView(textView);
    }
}
EOF

# Create build.gradle for app module
cat > app/build.gradle << 'EOF'
apply plugin: 'com.android.application'

android {
    compileSdkVersion 30
    defaultConfig {
        applicationId "com.termux.crush"
        minSdkVersion 21
        targetSdkVersion 30
        versionCode 1
        versionName "1.0.0"
    }
    
    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}
EOF

# Create top-level build.gradle
cat > build.gradle << 'EOF'
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:4.2.2'
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
EOF

# Create gradle.properties
cat > gradle.properties << 'EOF'
android.useAndroidX=true
android.enableJetifier=true
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
EOF

# Create settings.gradle
cat > settings.gradle << 'EOF'
rootProject.name = 'termux-crush-app'
include ':app'
EOF

# Create gradle wrapper directory and files
mkdir -p gradle/wrapper
cat > gradle/wrapper/gradle-wrapper.properties << 'EOF'
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-6.7.1-bin.zip
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
EOF

# Create gradlew script
cat > gradlew << 'EOF'
#!/bin/sh
exec java -jar "$PWD/gradle/wrapper/gradle-wrapper.jar" "$@"
EOF

chmod +x gradlew

# Create gradlew.bat for Windows
cat > gradlew.bat << 'EOF'
@echo off
java -jar "%~dp0gradle\wrapper\gradle-wrapper.jar" %*
EOF

# Try to build the APK if Android SDK is available
if command -v gradle &> /dev/null || [ -f "gradlew" ]; then
    echo "Attempting to build placeholder APK..."
    
    # Make gradlew executable
    chmod +x gradlew
    
    # Try to build
    if ./gradlew assembleRelease 2>/dev/null; then
        echo "Placeholder APK built successfully!"
        APK_PATH="app/build/outputs/apk/release/app-release-unsigned.apk"
        if [ -f "$APK_PATH" ]; then
            cp "$APK_PATH" "$OLDPWD/termux-crush-app-placeholder.apk"
            echo "Placeholder APK saved as: $OLDPWD/termux-crush-app-placeholder.apk"
        fi
    else
        echo "Could not build APK with Gradle. Creating simple placeholder..."
        echo "Placeholder APK for Termux Crush App v1.0.0" > "$OLDPWD/termux-crush-app-placeholder.apk"
    fi
else
    echo "Gradle not available. Creating simple placeholder file..."
    echo "Placeholder APK for Termux Crush App v1.0.0 - This needs to be replaced with actual build" > "$OLDPWD/termux-crush-app-placeholder.apk"
fi

# Clean up
cd /
rm -rf "$TEMP_DIR"

echo ""
echo "Placeholder APK creation completed!"
echo "=================================="
echo "Created: termux-crush-app-placeholder.apk"
echo "This file can be used as a placeholder in GitHub releases."
echo "It should be replaced with the actual built APK by someone with Android development environment."