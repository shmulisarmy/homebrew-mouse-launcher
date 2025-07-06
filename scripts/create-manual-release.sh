#!/bin/bash

# Script to manually create a GitHub release

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 1.0.1"
    exit 1
fi

VERSION=$1
TAG="v$VERSION"

echo "Creating manual release for version $VERSION"

# Check if binary exists
if [ ! -f "mouse_launcher_darwin_universal" ]; then
    echo "Building binary..."
    make build-darwin-arm64
    cp mouse_launcher_darwin_arm64 mouse_launcher_darwin_universal
fi

echo "Binary ready: mouse_launcher_darwin_universal"
echo ""
echo "Manual steps to create release:"
echo "1. Go to: https://github.com/shmulisarmy/homebrew-mouse-launcher/releases/new"
echo "2. Set tag to: $TAG"
echo "3. Set title to: Release $TAG"
echo "4. Upload the file: mouse_launcher_darwin_universal"
echo "5. Publish the release"
echo ""
echo "After creating the release, run:"
echo "./scripts/update-sha256.sh $VERSION" 