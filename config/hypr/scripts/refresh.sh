#!/bin/bash

SCRIPT_DIR="$HOME/.config/hypr/scripts"

pkill -x rofi

# waybar_mode.sh owns the kill and launch so a refresh keeps docked/overlay mode
"$SCRIPT_DIR"/waybar_mode.sh restart

sleep 0.5
"$SCRIPT_DIR"/wallpaper.sh

swaync-client --reload-config --reload-css

hyprctl reload
notify-send -u low " Hyprland" "Configuration reloaded"
exit 0
