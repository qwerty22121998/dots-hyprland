#!/bin/bash

CONFIG_DIR="$HOME/.config/hypr/configs/user"
ANIMATION_DIR="$HOME/.config/hypr/animations"
ROFI_CONFIG=$HOME/.config/hypr/scripts/rofi_choose.rasi

animations=$(ls "$ANIMATION_DIR"/*.conf | sed 's/.*\///' | sort -V)

anim_file=$(echo "$animations" |
  rofi -dmenu -i -config "$ROFI_CONFIG" -mesg "󰗘 Select animation" -p "Animation")

if [[ -n $anim_file ]]; then
  anim_path="$ANIMATION_DIR/$anim_file"
  cp "$anim_path" "$CONFIG_DIR/animations.conf"
  notify-send -u low "󰗘 Hyprland Animation" "Animation changed to $anim_file"
fi

echo "$anim_file"

