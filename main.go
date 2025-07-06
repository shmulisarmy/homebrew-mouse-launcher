package main

import (
	"flag"
	"fmt"
	"os"
	"os/exec"
	"sync"
	"time"

	"github.com/go-vgo/robotgo"
	hook "github.com/robotn/gohook"
)

const version = "1.0.0"

func move_mouse_clamped(dx, dy int) {
	x, y := robotgo.GetMousePos()
	screenWidth, screenHeight := robotgo.GetScreenSize()

	newX := x + dx
	newY := y + dy

	// Clamp
	if newX < 0 {
		newX = 0
	}
	if newY < 0 {
		newY = 0
	}
	if newX >= screenWidth {
		newX = screenWidth - 1
	}
	if newY >= screenHeight {
		newY = screenHeight - 1
	}

	robotgo.MoveMouse(newX, newY)
}

type Position struct {
	x int
	y int
}

type Direction struct {
	Position
	dir      string
	rawcode  uint16
	velocity int
}

func (d *Direction) move_mouse() {
	switch d.dir {
	case "left":
		move_mouse_clamped(-d.velocity, 0)
	case "right":
		move_mouse_clamped(d.velocity, 0)
	case "up":
		move_mouse_clamped(0, -d.velocity)
	case "down":
		move_mouse_clamped(0, d.velocity)
	}

}
func move_right(amount int) {
	cmd := exec.Command("cliclick", "m:"+fmt.Sprintf("+%d,+0", amount))
	fmt.Printf("Running command: %s\n", cmd.String())
	cmd.Run()
}

func move_down(amount int) {
	cmd := exec.Command("cliclick", "m:"+fmt.Sprintf("+0,-%d", amount))
	fmt.Printf("Running command: %s\n", cmd.String())
	cmd.Run()
}

func move_up(amount int) {
	cmd := exec.Command("cliclick", "m:"+fmt.Sprintf("+0,+%d", amount))
	fmt.Printf("Running command: %s\n", cmd.String())
	cmd.Run()
}

func move_left(amount int) {
	cmd := exec.Command("cliclick", "m:"+fmt.Sprintf("-%d,+0", amount))
	fmt.Printf("Running command: %s\n", cmd.String())
	cmd.Run()
}

func main() {
	showVersion := flag.Bool("version", false, "Show version information")
	flag.Parse()

	if *showVersion {
		fmt.Printf("mouse_launcher version %s\n", version)
		os.Exit(0)
	}

	fmt.Println("Hold arrow keys to move. ESC to quit.")

	// Replace these rawcodes with the values printed from your own keyboard
	directionsMap := map[uint16]*Direction{
		123: {Position: Position{x: -1, y: 0}, dir: "left", rawcode: 123, velocity: 0}, // left arrow
		125: {Position: Position{x: 0, y: 1}, dir: "down", rawcode: 125, velocity: 0},  // down arrow
		126: {Position: Position{x: 0, y: -1}, dir: "up", rawcode: 126, velocity: 0},   // up arrow
		124: {Position: Position{x: 1, y: 0}, dir: "right", rawcode: 124, velocity: 0}, // right arrow
	}

	var mu sync.RWMutex
	quit := make(chan struct{})

	// Keyboard event handler
	go func() {
		for ev := range hook.Start() {
			// Debug print to discover actual key codes

			if ev.Kind == hook.KeyDown {
				if ev.Rawcode == 53 { // ESC on macOS
					close(quit)
					return
				}
				mu.Lock()
				if dir, ok := directionsMap[ev.Rawcode]; ok {
					if dir.velocity == 0 {
						dir.velocity = 40
					}
				}
				mu.Unlock()
			}

			if ev.Kind == hook.KeyUp {
				mu.Lock()
				if dir, ok := directionsMap[ev.Rawcode]; ok {
					dir.velocity = 0
				}
				mu.Unlock()
			}
		}
	}()

	// Velocity updater
	go func() {
		for {
			select {
			case <-quit:
				return
			default:
				mu.Lock()
				for _, dir := range directionsMap {
					if dir.velocity > 0 {
						dir.velocity += 6
					}
				}
				mu.Unlock()
				time.Sleep(20 * time.Millisecond)
			}
		}
	}()

	// Game loop
	ticker := time.NewTicker(20 * time.Millisecond)
	defer ticker.Stop()

	for {
		select {
		case <-quit:
			fmt.Println("Exiting.")
			return
		case <-ticker.C:
			mu.RLock()
			for _, dir := range directionsMap {
				if dir.velocity > 0 {
					fmt.Printf("Moving %s at speed %d\n", dir.dir, dir.velocity)
					dir.move_mouse()
				}
			}
			mu.RUnlock()
		}
	}
}
