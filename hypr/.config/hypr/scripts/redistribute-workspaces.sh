#!/bin/bash

set -euo pipefail

LAPTOP_MONITOR="eDP-1"

move_range() {
    local start="$1"
    local end="$2"
    local monitor="$3"
    local workspace

    for workspace in $(seq "$start" "$end"); do
        hyprctl dispatch moveworkspacetomonitor "$workspace $monitor" >/dev/null
    done
}

monitors_json=$(hyprctl monitors -j)
external_monitors=$(printf '%s' "$monitors_json" | jq -r --arg laptop "$LAPTOP_MONITOR" '
    [.[] | select(.name != $laptop and .disabled == false)]
    | sort_by(.x)
    | .[].name
')

external_count=$(printf '%s\n' "$external_monitors" | sed '/^$/d' | wc -l)

if [ "$external_count" -ge 2 ]; then
    left_monitor=$(printf '%s\n' "$external_monitors" | sed -n '1p')
    right_monitor=$(printf '%s\n' "$external_monitors" | sed -n '2p')

    move_range 1 2 "$left_monitor"
    move_range 3 4 "$right_monitor"
    move_range 5 5 "$LAPTOP_MONITOR"
else
    move_range 1 5 "$LAPTOP_MONITOR"
fi
