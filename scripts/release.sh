#!/bin/bash

# Release script for mouse-launcher

set -e

# Check if version is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 1.0.0"
    exit 1
fi

VERSION=$1
TAG="v$VERSION"

echo "Creating release for version $VERSION"

# Detect current architecture
ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
    BINARY_NAME="mouse_launcher_darwin_arm64"
    GOARCH="arm64"
elif [ "$ARCH" = "x86_64" ]; then
    BINARY_NAME="mouse_launcher_darwin_amd64"
    GOARCH="amd64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# Build the binary for current architecture
echo "Building binary for $ARCH..."
go mod download
GOOS=darwin GOARCH=$GOARCH go build -o $BINARY_NAME main.go
chmod +x $BINARY_NAME

# Calculate SHA256
SHA256=$(shasum -a 256 $BINARY_NAME | cut -d' ' -f1)
echo "SHA256 for $BINARY_NAME: $SHA256"

# Create git tag
echo "Creating git tag $TAG..."
git add .
git commit -m "Release $TAG" || true
git tag -a $TAG -m "Release $TAG"
git push origin $TAG

echo "Release $TAG created successfully!"
echo "Binary: $BINARY_NAME"
echo "SHA256: $SHA256"
echo ""
echo "Next steps:"
echo "1. Create a GitHub release at: https://github.com/shmulisarmy/mouse-launcher/releases/new"
echo "2. Upload the $BINARY_NAME file to the release"
echo "3. Update the SHA256 in Formula/mouse-launcher.rb with: $SHA256" 