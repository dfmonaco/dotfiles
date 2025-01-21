#!/bin/bash

# -----------------------------------------------------
# Quit all running waybar and nm-applet instances
# -----------------------------------------------------

# Function to log messages
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

# Check if waybar is installed
if ! command -v waybar &> /dev/null; then
    log "waybar could not be found. Please install it."
    exit 1
fi

# Check if nm-applet is installed
if ! command -v nm-applet &> /dev/null; then
    log "nm-applet could not be found. Please install it."
    exit 1
fi

# Check if waybar is running
if pgrep -x waybar > /dev/null; then
    log "waybar is running. Killing waybar instances..."
    pkill waybar
    if [ $? -ne 0 ]; then
        log "Failed to kill waybar instances."
        exit 1
    fi
else
    log "waybar is not running."
fi

# Check if nm-applet is running
if pgrep -x nm-applet > /dev/null; then
    log "nm-applet is running. Killing nm-applet instances..."
    pkill nm-applet
    if [ $? -ne 0 ]; then
        log "Failed to kill nm-applet instances."
        exit 1
    fi
else
    log "nm-applet is not running."
fi

# Wait for half a second
log "Waiting for 0.5 seconds..."
sleep 0.5

# Run waybar
log "Starting nm-applet..."
nm-applet &
if [ $? -ne 0 ]; then
    log "Failed to start nm-applet."
    exit 1
fi

log "Starting waybar..."
waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/themes/ml4w-modern/dark/style.css
if [ $? -ne 0 ]; then
    log "Failed to start waybar."
    exit 1
fi

log "waybar and nm-applet started successfully."
