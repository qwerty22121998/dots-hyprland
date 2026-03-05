
#!/bin/bash



SCRIPT_DIR="$HOME/.config/hypr/scripts"
ROFI_CONFIG="$SCRIPT_DIR/rofi_choose.rasi"

processes=$(ps -eo comm= | sort -u)

selected_process=$(echo "$processes" | rofi -dmenu -i -config "$ROFI_CONFIG" -mesg "💀 Select a process to kill" -p "Kill process")

if [ -n "$selected_process" ]; then
    pkill "$selected_process"
    notify-send -u low "💀 Process Killer" "Killed process: $selected_process"
fi
