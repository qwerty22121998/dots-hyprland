#!/bin/bash

SCRIPT_DIR="$HOME/.config/hypr/scripts"

process=(waybar rofi swaync)

for p in "${process[@]}"; do
  if pidof "${p}" >/dev/null; then
    pkill "${p}"
  fi
done

sleep 0.5
waybar &

sleep 0.5
swaync >/dev/null 2>&1 &
swaync-client -R -rs

sleep 0.5
"$SCRIPT_DIR"/wallpaper.sh

notify-send -u low " Hyprland" "Configuration reloaded"
exit 0
