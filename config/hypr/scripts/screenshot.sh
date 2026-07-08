#!/bin/bash

set -o pipefail

SCRIPT_DIR="$HOME/.config/hypr/scripts"
PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"

screenshot() {
  if grim -g "$(slurp)" - | wl-copy; then
    notify-send -u low "󰹑 Screenshot" "Screenshot taken and copied to clipboard!"
    "$SCRIPT_DIR/sound.sh" screen-capture
  fi
}

screenshot_save() {
  mkdir -p "$PICTURES_DIR"
  local file="$PICTURES_DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"
  if grim -g "$(slurp)" "$file"; then
    wl-copy <"$file"
    notify-send -u low "󰹑 Screenshot" "Saved to $file"
    "$SCRIPT_DIR/sound.sh" screen-capture
  fi
}

case "$1" in
save) screenshot_save ;;
*) screenshot ;;
esac
