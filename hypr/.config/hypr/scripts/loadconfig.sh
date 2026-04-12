#!/bin/bash

hyprctl reload
sleep 1
~/.config/hypr/scripts/redistribute-workspaces.sh
