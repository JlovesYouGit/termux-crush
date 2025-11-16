# Build and Release Instructions

This document provides instructions for building the actual APK and creating a proper release.

## Prerequisites
- Android Studio
- Docker
- Git

## Steps to Build the Actual APK

### 1. Clone Required Repositories
```bash
git clone https://github.com/termux/termux-app
git clone https://github.com/termux/termux-packages
```

### 2. Set Up Package Name
1. Open the termux-app project in Android Studio
2. Refactor `com.termux` to `com.termux.crush` throughout the project
3. Update `TERMUX_APP_PACKAGE` in `app/build.gradle` to `com.termux.crush`

### 3. Build Packages Using Docker
```bash
cd termux-packages
./scripts/run-docker.sh
```

Inside the Docker container:
```bash
# Build for all architectures you want to support
./build-package.sh -a aarch64 git
./build-package.sh -a aarch64 golang
./build-package.sh -a aarch64 vim
./build-package.sh -a aarch64 neovim
# Build Crush CLI package (custom)
./build-package.sh -a aarch64 crush
```

### 4. Create Custom Bootstrap
```bash
./scripts/build-bootstrap.sh --architectures aarch64,arm,i686,x86_64
```

### 5. Integrate Bootstrap with App
1. Copy the generated bootstrap ZIP files to the Termux app:
   ```bash
   cp bootstrap-*.zip ../termux-app/app/src/main/cpp/
   ```

2. Modify `app/build.gradle` to remove the downloadBootstrap task or comment it out:
   ```gradle
   task downloadBootstraps() {
       return;  // Skip downloading official bootstrap
       // ... rest of the task
   }
   ```

### 6. Build the APK
1. Open the Termux app project in Android Studio
2. Clean and build the project
3. Generate signed APK

### 7. Replace Placeholder APK
1. Copy the built APK to this directory
2. Rename it to `termux-crush-app-v1.0.0.apk`
3. Upload it to the GitHub release

## GitHub Release Update

After building the actual APK:

1. Go to https://github.com/JlovesYouGit/termux-crush/releases
2. Find the v1.0.0 release
3. Click "Edit release"
4. Delete the placeholder APK
5. Upload the actual APK
6. Update the release notes to indicate it now contains the actual APK
7. Remove the "pre-release" flag
8. Click "Update release"

## Testing the Release

Test the APK on:
- Nothing Phone 2
- Pixel phones (4, 5, 6, 7)
- Other Android 7.0+ devices

Verify that:
- Installation works correctly
- Crush CLI functions properly
- Vim/Neovim editors work
- Git and Go are available
- No conflicts with existing Termux installations