# Instructions to Push to GitHub

This document provides step-by-step instructions to push the termux-crush repository to GitHub.

## Prerequisites

1. A GitHub account
2. Git installed on your system (already done)
3. This local repository (already set up)

## Steps to Push to GitHub

### 1. Create a New Repository on GitHub

1. Go to https://github.com/new
2. Enter repository name: `termux-crush`
3. Add description: "Termux-compatible version of Crush CLI for Android 15+"
4. Choose Public (or Private if you prefer)
5. **Do NOT initialize with a README**
6. Click "Create repository"

### 2. Set the Remote Origin and Push

In your terminal, run the following commands:

```bash
# Navigate to the repository directory
cd c:\Users\JJ\Downloads\lest\termux-crush

# Set the remote origin (replace YOUR_USERNAME with your actual GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/termux-crush.git

# Push the changes
git push -u origin master
```

If you get authentication errors, you may need to use a Personal Access Token:

```bash
# Replace YOUR_USERNAME and YOUR_TOKEN with your actual GitHub username and token
git remote set-url origin https://YOUR_USERNAME:YOUR_TOKEN@github.com/YOUR_USERNAME/termux-crush.git
git push -u origin master
```

### 3. Verify the Push

After pushing, you should be able to see your code at:
`https://github.com/YOUR_USERNAME/termux-crush`

## Making Future Updates

To make future updates to your repository:

```bash
# Make your changes
# ...

# Add and commit changes
git add .
git commit -m "Description of changes"

# Push to GitHub
git push origin master
```

## Sharing with Others

Once your repository is set up, others can install the Termux-compatible version of Crush by:

```bash
# Install dependencies
pkg update && pkg upgrade
pkg install golang git

# Install Crush directly with Go
go install github.com/YOUR_USERNAME/termux-crush@latest

# Run Crush
crush
```

Or they can clone the repository and build from source:

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/termux-crush.git
cd termux-crush

# Build and install
go install .

# Run Crush
crush
```