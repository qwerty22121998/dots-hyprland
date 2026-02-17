#!/bin/bash

set -o pipefail

SCRIPT_DIR="$HOME/.config/hypr/scripts"

screenshot() {
  if grim -g "$(slurp)" - | wl-copy; then
    notify-send -u low "󰹑 Screenshot" "Screenshot taken and copied to clipboard!"
    "$SCRIPT_DIR/sound.sh" screen-capture
  fi
}

screenshot

