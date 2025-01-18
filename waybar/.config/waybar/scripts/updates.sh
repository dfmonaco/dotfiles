#!/bin/bash

# ----------------------------------------------------- 
# Define thresholds for color indicators
# ----------------------------------------------------- 

threshold_green=0
threshold_yellow=25
threshold_red=100

# ----------------------------------------------------- 
# Function to calculate available updates
# ----------------------------------------------------- 

get_update_count() {
    # Get updates from official repositories
    repo_updates=$(checkupdates 2>/dev/null | wc -l || echo 0)
    
    # Get updates from AUR packages
    aur_updates=$(pacman -Qm 2>/dev/null | aur vercmp | wc -l || echo 0)
    
    # Total updates
    echo $((repo_updates + aur_updates))
}

# ----------------------------------------------------- 
# Calculate updates and determine CSS class
# ----------------------------------------------------- 

updates=$(get_update_count)
css_class="green"

if [ "$updates" -gt "$threshold_red" ]; then
    css_class="red"
elif [ "$updates" -gt "$threshold_yellow" ]; then
    css_class="yellow"
fi

# ----------------------------------------------------- 
# Output in JSON format for Waybar Module custom-updates
# ----------------------------------------------------- 

if [ "$updates" -gt "$threshold_green" ]; then
    tooltip="Please update your system"
else
    tooltip="Your system is up to date"
fi

printf '{"text": "%s", "alt": "%s", "tooltip": "%s", "class": "%s"}\n' \
    "$updates" "$updates" "$tooltip" "$css_class"
