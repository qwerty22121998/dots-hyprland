#!/bin/bash

SCRIPT_DIR="$HOME/.config/hypr/scripts"

process=(waybar rofi)

for p in "${process[@]}"; do
  if pidof -x "${p}" >/dev/null; then
    pkill -x "${p}"
  fi
done

sleep 0.5
# waybar_mode.sh owns the launch so a refresh keeps docked/overlay mode
"$SCRIPT_DIR"/waybar_mode.sh restart

sleep 0.5
"$SCRIPT_DIR"/wallpaper.sh

makoctl reload

hyprctl reload
notify-send -u low " Hyprland" "Configuration reloaded"
exit 0
