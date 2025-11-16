# Deployment Instructions

## Creating GitHub Repository

1. Go to https://github.com/new
2. Create a new repository named `termux-crush-app`
3. Don't initialize with a README
4. Copy the repository URL (e.g., `https://github.com/yourusername/termux-crush-app.git`)

## Pushing Code to GitHub

1. Add the remote repository:
   ```bash
   git remote add origin https://github.com/yourusername/termux-crush-app.git
   ```

2. Push the code:
   ```bash
   git push -u origin master
   ```

## Creating Release

1. Go to the GitHub repository releases page
2. Click "Draft a new release"
3. Create a new tag (e.g., v1.0.0)
4. Add release notes
5. Publish release

## Building APK for Release

1. Follow the build instructions in BUILD_INSTRUCTIONS.md
2. Build the APK using Android Studio
3. Upload the APK to the GitHub release

## Continuous Integration (Optional)

To set up CI/CD for automatic builds:

1. Create a `.github/workflows` directory
2. Add a workflow file for building the APK
3. Configure the workflow to run on pushes to master
4. Set up automatic release creation