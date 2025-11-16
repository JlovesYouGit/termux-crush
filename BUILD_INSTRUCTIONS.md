# Building Custom Termux Crush App

## Prerequisites

- Android Studio
- Docker (for building packages)
- Git

## Step 1: Clone Termux App Source

```bash
git clone https://github.com/termux/termux-app
cd termux-app
```

## Step 2: Refactor Package Name

1. Open the project in Android Studio
2. Refactor `com.termux` to `com.termux.crush` throughout the project
3. Update `TERMUX_APP_PACKAGE` in `app/build.gradle` to `com.termux.crush`

## Step 3: Clone Termux Packages Repository

```bash
git clone https://github.com/termux/termux-packages
cd termux-packages
```

## Step 4: Prepare Build Environment

1. Download the build-bootstrap.sh script:
   ```bash
   wget https://gist.github.com/seeya/a9ce074cf560aa7113043859360b7bfc/raw/206b5f4755b65569cf4af8d92b2481258c134b74/build-bootstrap.sh
   mv build-bootstrap.sh scripts/
   ```

2. Edit `scripts/properties.sh` and set:
   ```bash
   TERMUX_APP_PACKAGE="com.termux.crush"
   ```

## Step 5: Build Required Packages

1. Start Docker container:
   ```bash
   ./scripts/run-docker.sh
   ```

2. Inside the Docker container, build the required packages:
   ```bash
   # Build for all architectures you want to support
   ./build-package.sh -a aarch64 git
   ./build-package.sh -a aarch64 golang
   ./build-package.sh -a aarch64 vim
   ./build-package.sh -a aarch64 neovim
   # Build Crush CLI package (custom)
   ./build-package.sh -a aarch64 crush
   ```

## Step 6: Create Custom Bootstrap

1. Create a script to install Crush during bootstrap:
   ```bash
   # Create a post-install script
   cat > packages/crush/postinst << 'EOF'
   #!/bin/sh
   set -e
   # Install Crush CLI
   go install github.com/JlovesYouGit/termux-crush@latest
   EOF
   ```

2. Build the bootstrap:
   ```bash
   ./scripts/build-bootstrap.sh --architectures aarch64,arm,i686,x86_64
   ```

## Step 7: Integrate Bootstrap with App

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

## Step 8: Build the APK

1. Open the Termux app project in Android Studio
2. Clean and build the project
3. Generate signed APK

## Step 9: Testing

1. Install the APK on an Android device
2. Launch the app
3. Verify that Crush CLI is available:
   ```bash
   crush --help
   ```

## Customization Options

### Adding More Pre-installed Packages

To add more packages to the bootstrap:

1. Build additional packages in the Docker container:
   ```bash
   ./build-package.sh -a aarch64 <package-name>
   ```

2. Rebuild the bootstrap with all packages included

### Custom Configuration

You can add custom configuration files by modifying the bootstrap creation process:

1. Add config files to the package directory
2. Create post-install scripts for configuration
3. Rebuild the bootstrap

## Troubleshooting

### Common Issues

1. **Package conflicts**: Ensure all package names are unique
2. **Architecture mismatches**: Build for all target architectures
3. **Bootstrap size**: Only include necessary packages to keep APK size reasonable

### Debugging

1. Check Android logs:
   ```bash
   adb logcat | grep termux
   ```

2. Enable debug mode in the app settings

3. Check package installation logs in Termux home directory