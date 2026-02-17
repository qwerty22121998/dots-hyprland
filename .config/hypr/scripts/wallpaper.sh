#!/bin/bash

PICTURE_DIR="$HOME/Pictures/Wallpapers"

focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name')
current_wallpaper=$(awww query -j | jq -r ".\"\"[] | select(.name==\"$focused_monitor\") | .displaying.image")
echo "Focused monitor: $focused_monitor"
echo "Current wallpaper: $current_wallpaper"

ln -sf "$current_wallpaper" "$PICTURE_DIR/_current_wallpaper" 2>/dev/null
#link rofi
ln -sf "$current_wallpaper" "$HOME/.config/rofi/_current_wallpaper" 2>/dev/null
