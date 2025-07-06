# Mouse Launcher

A simple mouse movement utility for macOS that allows you to control mouse movement using arrow keys.

## Features

- Hold arrow keys to move the mouse cursor
- Smooth acceleration for precise control
- Screen boundary clamping to prevent cursor from going off-screen
- Press ESC to quit

## Installation

### Using Homebrew (Recommended)

```bash
brew install shmulisarmy/mouse-launcher/mouse-launcher
```

### Manual Installation

1. Download the latest release for your platform
2. Make it executable: `chmod +x mouse_launcher`
3. Move to your PATH: `sudo mv mouse_launcher /usr/local/bin/`

## Usage

1. Run the application: `mouse_launcher`
2. Hold arrow keys to move the mouse cursor
3. Press ESC to quit

## Building from Source

```bash
go mod download
go build -o mouse_launcher main.go
```

## Requirements

- macOS (tested on macOS 14+)
- Go 1.24+ (for building from source)

## License

MIT License # mouse-launcher
# homebrew-mouse-launcher
