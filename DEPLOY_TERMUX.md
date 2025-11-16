# Deploying Crush-Termux to GitHub

This guide will help you create a new GitHub repository for the Termux-compatible version of Crush and push the changes.

## Prerequisites

1. A GitHub account
2. Git installed on your system
3. The modified Crush codebase

## Steps to Deploy

### 1. Create a New GitHub Repository

1. Go to https://github.com/new
2. Enter repository name: `crush-termux`
3. Add description: "Termux-compatible version of Crush CLI for Android 15+"
4. Choose Public (or Private if you prefer)
5. **Do NOT initialize with a README**
6. Click "Create repository"

### 2. Push the Code to Your New Repository

Open a terminal and navigate to the Crush directory:

```bash
cd c:\Users\JJ\Downloads\lest\crush
```

Add your GitHub username to the remote URL and push:

```bash
# Replace YOUR_USERNAME with your actual GitHub username
git remote set-url origin https://github.com/YOUR_USERNAME/crush-termux.git
git push -u origin main
```

If you get authentication errors, you may need to use a Personal Access Token:

```bash
# Replace YOUR_USERNAME and YOUR_TOKEN with your actual GitHub username and token
git remote set-url origin https://YOUR_USERNAME:YOUR_TOKEN@github.com/YOUR_USERNAME/crush-termux.git
git push -u origin main
```

### 3. Alternative: Create a New Repository from Scratch

If you prefer to start with a clean repository:

```bash
# Create a new directory
mkdir crush-termux
cd crush-termux

# Initialize git repository
git init

# Copy the modified files from the original crush directory
cp -r c:\Users\JJ\Downloads\lest\crush\internal\platform .
cp c:\Users\JJ\Downloads\lest\crush\internal\config\load.go .
cp c:\Users\JJ\Downloads\lest\crush\internal\config\provider.go .
cp c:\Users\JJ\Downloads\lest\crush\README.md .
cp c:\Users\JJ\Downloads\lest\crush\TERMUX_INSTALL.md .

# Add and commit files
git add .
git commit -m "Add Termux/Android support for Crush CLI"

# Add remote and push
git remote add origin https://github.com/YOUR_USERNAME/crush-termux.git
git branch -M main
git push -u origin main
```

## Making Updates

To make future updates to your repository:

```bash
# Make your changes
# ...

# Add and commit changes
git add .
git commit -m "Description of changes"

# Push to GitHub
git push origin main
```

## Sharing with Others

Once your repository is set up, others can install the Termux-compatible version of Crush by:

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/crush-termux.git
cd crush-termux

# Install
go install .
```

Or directly install with Go:

```bash
go install github.com/YOUR_USERNAME/crush-termux@latest
```