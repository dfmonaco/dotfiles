#!/usr/bin/env sh

# Terminate alredy running ar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar

polybar top -r &

echo "Bar launched..."
