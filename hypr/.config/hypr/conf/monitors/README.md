# Hyprland Monitor Configuration Guide

## Current Setup

Your Hyprland is configured to automatically detect and adapt to two scenarios:

### 1. Laptop Only (Undocked)
- **eDP-1**: 2880x1800 @ 1.5x scaling (primary and only display)
- All workspaces (1-9) are accessible on the laptop screen

### 2. Docked Setup (3 Monitors)
```
┌──────────────┬──────────────┐
│    DP-5      │    DP-6      │  <- External monitors
│  1920x1080   │  1920x1080   │     (side by side)
│  WS: 1-3     │  WS: 4-6     │
└──────┬───────┴──────────────┘
       │      eDP-1
       │   2880x1800 @ 1.5x    <- Laptop screen
       │     WS: 7-9           (centered below)
       └──────────────────────
```

**Monitor Details:**
- **DP-5** (Left): 1920x1080 @ 60Hz - Workspaces 1-3
- **DP-6** (Right): 1920x1080 @ 60Hz - Workspaces 4-6
- **eDP-1** (Laptop): 2880x1800 @ 60Hz, 1.5x scaling - Workspaces 7-9

## How It Works

The configuration automatically detects which monitors are connected:
- When external monitors are connected, they activate with assigned workspaces
- When disconnected, all workspaces gracefully fall back to the laptop screen
- No manual configuration switching needed

## Testing the Configuration

### Reload Hyprland Configuration
```bash
# Method 1: Keybinding (if configured)
Super + Shift + R

# Method 2: Command
hyprctl reload

# Method 3: Full restart (if reload doesn't work)
Super + Shift + E  # Exit Hyprland
# Then log back in
```

### Check Current Monitor Setup
```bash
# List all connected monitors
hyprctl monitors

# Get detailed monitor info
hyprctl monitors all
```

### Test Workspaces
- Press `Super + 1` through `Super + 9` to switch between workspaces
- When docked: workspaces should open on their assigned monitors
- When undocked: all workspaces should work on laptop screen

## Customization

### Change Scaling on Laptop
Edit `/home/diego/dotfiles/hypr/.config/hypr/conf/monitors/default.conf`:
```conf
# Current: 1.5x scaling (recommended)
monitor = eDP-1, 2880x1800@60, 0x1080, 1.5

# Options:
# - 1.0  = No scaling (very small text, max space)
# - 1.25 = Slight scaling
# - 1.5  = Balanced (recommended) ← current
# - 2.0  = Large scaling (easier on eyes)
```

### Adjust Monitor Positions
```conf
# Format: monitor = NAME, RES@REFRESH, X_POS x Y_POS, SCALE

# Example: Move laptop screen to the left
monitor = eDP-1, 2880x1800@60, -1920x0, 1.5
```

### Change Workspace Assignments
Edit `/home/diego/dotfiles/hypr/.config/hypr/conf/workspaces/default.conf`:
```conf
# Reassign workspaces to different monitors
workspace = 1, monitor:DP-6  # Move WS 1 to right monitor
```

## Switching Between Preset Configurations

If you want to manually switch between different monitor setups:

```bash
# Use a different preset
cd ~/.config/hypr/conf/monitors/

# Available presets:
# - default.conf (current: auto-detect 3-monitor + laptop)
# - 1920x1080.conf (simple 1080p)
# - 2560x1440.conf (1440p)
# - highres.conf (auto high-res)

# To switch, edit monitor.conf:
# source = ~/.config/hypr/conf/monitors/YOUR_CHOICE.conf
```

## Troubleshooting

### Monitors not detected
```bash
# Check connected displays
hyprctl monitors
xrandr  # Alternative tool

# Force reload
hyprctl reload
```

### Wrong workspace on wrong monitor
```bash
# Move current workspace to specific monitor
hyprctl dispatch moveworkspacetomonitor 1 DP-5

# Or just reload config
hyprctl reload
```

### External monitors not activating
1. Check physical connections
2. Run: `hyprctl monitors` to see detected displays
3. Verify monitor names match in config (DP-5, DP-6 might be DP-1, DP-2 on your system)

### Finding Your Monitor Names
```bash
# List all detected monitors with their names
hyprctl monitors | grep "Monitor"

# Example output:
# Monitor DP-5 (ID 0): ...
# Monitor DP-6 (ID 1): ...
# Monitor eDP-1 (ID 2): ...
```

If your monitor names differ (e.g., DP-1 instead of DP-5), update the config accordingly.

## Additional Resources

- [Hyprland Monitor Wiki](https://wiki.hyprland.org/Configuring/Monitors/)
- [Hyprland Workspace Wiki](https://wiki.hyprland.org/Configuring/Workspace-Rules/)
