# Mouse Launcher - Homebrew Tap

This repository contains the Homebrew formula for [Mouse Launcher](https://github.com/shmulisarmy/mouse-launcher), a simple mouse movement utility for macOS that allows you to control mouse movement using arrow keys.

## Installation

### Using Homebrew (Recommended)

```bash
brew install shmulisarmy/mouse-launcher/mouse-launcher
```

### Manual Installation

If you prefer to install manually:

1. Download the latest release for your platform from [GitHub Releases](https://github.com/shmulisarmy/mouse-launcher/releases)
2. Make it executable: `chmod +x mouse_launcher_darwin_universal`
3. Move to your PATH: `sudo mv mouse_launcher_darwin_universal /usr/local/bin/mouse_launcher`

## Usage

1. Run the application: `mouse_launcher`
2. Hold arrow keys to move the mouse cursor
3. Press ESC to quit

## Features

- Hold arrow keys to move the mouse cursor
- Smooth acceleration for precise control
- Screen boundary clamping to prevent cursor from going off-screen
- Universal binary supporting both Intel and Apple Silicon Macs
- Press ESC to quit

## Requirements

- macOS (tested on macOS 14+)
- Universal binary supports both Intel (AMD64) and Apple Silicon (ARM64) Macs

## Development

### Building from Source

```bash
git clone https://github.com/shmulisarmy/mouse-launcher.git
cd mouse-launcher
go mod download
go build -o mouse_launcher main.go
```

### Updating the Formula

1. Create a new release on the main repository
2. Update the version and SHA256 in `Formula/mouse-launcher.rb`
3. Commit and push the changes

## License

MIT License - see the [main repository](https://github.com/shmulisarmy/mouse-launcher) for details.
