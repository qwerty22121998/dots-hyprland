#!/bin/bash

SCRIPT_DIR="$HOME/.config/hypr/scripts"
ROFI_CONFIG=$HOME/.config/hypr/scripts/rofi_wallpaper.rasi
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

wallpaper_file=$(ls "$WALLPAPER_DIR"/*.{jpg,png} 2>/dev/null |
  sed 's/.*\///' | while read img; do echo -en "$img\0icon\x1fthumbnail://$WALLPAPER_DIR/$img\n"; done |
  rofi -dmenu -i -config "$ROFI_CONFIG" -mesg "󰸉 Select wallpaper" -p "Wallpaper")
if [[ -n $wallpaper_file ]]; then
  wallpaper_path="$WALLPAPER_DIR/$wallpaper_file"
  current_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name')
  awww img -o "$current_monitor" "$wallpaper_path"
  notify-send -u low "󰸉 Hyprland Wallpaper" "Wallpaper on $current_monitor changed to $wallpaper_file"
  "$SCRIPT_DIR"/wallpaper.sh
fi

echo "$wallpaper_file"
