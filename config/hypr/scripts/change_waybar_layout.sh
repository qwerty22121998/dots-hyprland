#!/bin/bash

SCRIPT_DIR="$HOME/.config/hypr/scripts"
CONFIG_FILE="$HOME/.config/waybar/config.jsonc"
LAYOUT_DIR="$HOME/.config/waybar/layouts"
ROFI_CONFIG="$SCRIPT_DIR/rofi_choose.rasi"

layouts=$(ls "$LAYOUT_DIR"/*.jsonc | sed 's/.*\///' | sort -V)


layout_file=$(echo "$layouts" |
rofi -dmenu -i -config "$ROFI_CONFIG" -mesg " Select waybar layout" -p "Waybar layout")

if [[ -n $layout_file ]]; then
  layout_path="$LAYOUT_DIR/$layout_file"
  cp "$layout_path" "$CONFIG_FILE"
  "$SCRIPT_DIR/refresh.sh"
fi