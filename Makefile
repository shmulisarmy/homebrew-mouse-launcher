.PHONY: build clean release test install build-universal

# Build the application for current architecture
build:
	go mod download
	go build -o mouse_launcher main.go
	chmod +x mouse_launcher

# Build for specific architectures
build-darwin-amd64:
	go mod download
	GOOS=darwin GOARCH=amd64 go build -o mouse_launcher_darwin_amd64 main.go
	chmod +x mouse_launcher_darwin_amd64

build-darwin-arm64:
	go mod download
	GOOS=darwin GOARCH=arm64 go build -o mouse_launcher_darwin_arm64 main.go
	chmod +x mouse_launcher_darwin_arm64

# Build universal binary for both architectures
build-universal: build-darwin-amd64 build-darwin-arm64
	lipo -create -output mouse_launcher_darwin_universal mouse_launcher_darwin_amd64 mouse_launcher_darwin_arm64
	chmod +x mouse_launcher_darwin_universal

# Clean build artifacts
clean:
	rm -f mouse_launcher
	rm -f mouse_launcher_*

# Run tests
test:
	go test ./...

# Install locally
install: build
	sudo cp mouse_launcher /usr/local/bin/mouse_launcher

# Create a release (usage: make release VERSION=1.0.0)
release:
	@if [ -z "$(VERSION)" ]; then \
		echo "Usage: make release VERSION=1.0.0"; \
		exit 1; \
	fi
	./scripts/release.sh $(VERSION)

# Show help
help:
	@echo "Available targets:"
	@echo "  build              - Build the application for current architecture"
	@echo "  build-darwin-amd64 - Build for macOS AMD64"
	@echo "  build-darwin-arm64 - Build for macOS ARM64"
	@echo "  build-universal    - Build universal binary for both architectures"
	@echo "  clean              - Remove build artifacts"
	@echo "  test               - Run tests"
	@echo "  install            - Install to /usr/local/bin"
	@echo "  release            - Create a release (VERSION=1.0.0)"
	@echo "  help               - Show this help message" 