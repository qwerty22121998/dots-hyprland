#!/bin/bash

SCRIPT_DIR="$HOME/.config/hypr/scripts"
ROFI_CONFIG="$SCRIPT_DIR/rofi_choose.rasi"

processes=$(ps -u "$USER" -o comm= | sort -u)

selected_process=$(echo "$processes" | rofi -dmenu -i -config "$ROFI_CONFIG" -mesg "💀 Select a process to kill" -p "Kill process")

if [ -n "$selected_process" ]; then
    # -x: exact name, a bare pattern is a substring match and takes zsh/bash/ssh down with "sh"
    pkill -x -u "$USER" "$selected_process" &&
        notify-send -u low "💀 Process Killer" "Killed process: $selected_process"
fi
