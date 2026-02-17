#!/bin/bash

CONFIG_FILE="$HOME/.config/waybar/style.css"
THEME_DIR="$HOME/.config/waybar/themes"
ROFI_CONFIG=$HOME/.config/hypr/scripts/rofi_choose.rasi

themes=$(ls "$THEME_DIR"/*.css | sed 's/.*\///' | sort -V)


theme_file=$(echo "$themes" |
rofi -dmenu -i -config "$ROFI_CONFIG" -mesg " Select waybar theme" -p "Waybar theme")

if [[ -n $theme_file ]]; then
  theme_path="$THEME_DIR/$theme_file"
  cp "$theme_path" "$CONFIG_FILE"
  notify-send -u low " Waybar Theme" "Theme changed to $theme_file"
fi