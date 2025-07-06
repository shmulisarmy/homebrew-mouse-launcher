#!/bin/bash

# Script to update SHA256 in the formula after a release is created

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 1.0.1"
    exit 1
fi

VERSION=$1
URL="https://github.com/shmulisarmy/mouse-launcher/releases/download/v$VERSION/mouse_launcher_darwin_universal"

echo "Downloading binary to calculate SHA256..."
curl -L -o temp_binary "$URL"

echo "Calculating SHA256..."
SHA256=$(shasum -a 256 temp_binary | cut -d' ' -f1)
echo "SHA256: $SHA256"

echo "Updating formula..."
sed -i.bak "s/sha256 \"PLACEHOLDER_SHA256\"/sha256 \"$SHA256\"/" Formula/mouse-launcher.rb

echo "Cleaning up..."
rm temp_binary
rm Formula/mouse-launcher.rb.bak

echo "Formula updated with SHA256: $SHA256"
echo "Don't forget to commit and push the changes!" 