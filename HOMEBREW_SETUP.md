# Homebrew Setup Guide

This guide explains how to set up the mouse-launcher for Homebrew installation.

## Prerequisites

1. A GitHub account
2. The mouse-launcher repository pushed to GitHub
3. GitHub Actions enabled for the repository

## Step 1: Create a GitHub Repository

1. Create a new repository on GitHub named `mouse-launcher`
2. Push your code to the repository:

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/mouse-launcher.git
git push -u origin main
```

## Step 2: Create a Homebrew Tap

1. Create a new repository named `homebrew-mouse-launcher` (the `homebrew-` prefix is required)
2. This will be your Homebrew tap repository

## Step 3: Set up the Formula

1. Copy the `Formula/mouse-launcher.rb` file to your tap repository
2. Update the formula with your GitHub username:

```ruby
class MouseLauncher < Formula
  desc "A simple mouse movement utility for macOS using arrow keys"
  homepage "https://github.com/YOUR_USERNAME/mouse-launcher"
  version "1.0.0"
  
  if OS.mac?
    url "https://github.com/YOUR_USERNAME/mouse-launcher/releases/download/v1.0.0/mouse_launcher_darwin_amd64"
    sha256 "PLACEHOLDER_SHA256" # This will need to be updated after release
  end

  def install
    if OS.mac?
      bin.install "mouse_launcher_darwin_amd64" => "mouse_launcher"
    end
  end

  test do
    system "#{bin}/mouse_launcher", "--version"
  end
end
```

## Step 4: Create a Release

1. Run the release script:

```bash
./scripts/release.sh 1.0.0
```

2. This will:
   - Build the binary
   - Create a git tag
   - Trigger the GitHub Action to create a release

## Step 5: Update the Formula SHA256

1. After the release is created, download the binary and calculate its SHA256:

```bash
curl -L https://github.com/YOUR_USERNAME/mouse-launcher/releases/download/v1.0.0/mouse_launcher_darwin_amd64 -o mouse_launcher_darwin_amd64
shasum -a 256 mouse_launcher_darwin_amd64
```

2. Update the `sha256` field in your formula with the calculated hash

## Step 6: Test the Formula

1. Add your tap to Homebrew:

```bash
brew tap YOUR_USERNAME/mouse-launcher
```

2. Install the formula:

```bash
brew install mouse-launcher
```

3. Test the installation:

```bash
mouse_launcher --version
```

## Step 7: Make it Public

Once everything is working, you can make both repositories public so anyone can install your tool with:

```bash
brew install YOUR_USERNAME/mouse-launcher/mouse-launcher
```

## Troubleshooting

### Common Issues

1. **SHA256 mismatch**: Make sure to update the SHA256 after each release
2. **Permission denied**: Ensure the binary is executable (`chmod +x`)
3. **Formula not found**: Check that the tap repository name starts with `homebrew-`

### Testing Locally

You can test the formula locally before pushing:

```bash
brew install --build-from-source Formula/mouse-launcher.rb
```

## Maintenance

For future releases:

1. Update the version in `main.go`
2. Update the version in `Formula/mouse-launcher.rb`
3. Run `./scripts/release.sh <new_version>`
4. Update the SHA256 in the formula
5. Push the updated formula to your tap repository 