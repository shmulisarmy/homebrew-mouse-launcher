.PHONY: build clean release test install

# Build the application
build:
	go mod download
	GOOS=darwin GOARCH=amd64 go build -o mouse_launcher_darwin_amd64 main.go
	chmod +x mouse_launcher_darwin_amd64

# Clean build artifacts
clean:
	rm -f mouse_launcher
	rm -f mouse_launcher_*

# Run tests
test:
	go test ./...

# Install locally
install: build
	sudo cp mouse_launcher_darwin_amd64 /usr/local/bin/mouse_launcher

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
	@echo "  build    - Build the application for macOS"
	@echo "  clean    - Remove build artifacts"
	@echo "  test     - Run tests"
	@echo "  install  - Install to /usr/local/bin"
	@echo "  release  - Create a release (VERSION=1.0.0)"
	@echo "  help     - Show this help message" 