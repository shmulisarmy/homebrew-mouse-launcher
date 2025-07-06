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

# Build the binary
echo "Building binary..."
go mod download
GOOS=darwin GOARCH=amd64 go build -o mouse_launcher_darwin_amd64 main.go
chmod +x mouse_launcher_darwin_amd64

# Create git tag
echo "Creating git tag $TAG..."
git tag -a $TAG -m "Release $TAG"
git push origin $TAG

echo "Release $TAG created successfully!"
echo "The GitHub Action will automatically build and create a release."
echo "After the release is created, update the SHA256 in Formula/mouse-launcher.rb" 