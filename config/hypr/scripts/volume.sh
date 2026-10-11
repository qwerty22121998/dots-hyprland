#!/bin/bash

SCRIPT_DIR="$HOME/.config/hypr/scripts"

notify() {
  local -r volume=$(pamixer --get-volume)

  if is_mute; then
    notify-send -u low -h string:x-canonical-private-synchronous:volume "󰖁 Volume" "Muted"
  else
    notify-send -u low -h string:x-canonical-private-synchronous:volume -h "int:value:$volume" "󰕾 Volume" "$volume%" && "$SCRIPT_DIR/sound.sh" message
  fi
}

is_mute() {
  [[ "$(pamixer --get-mute)" == "true" ]]
}

is_mic_mute() {
  [[ "$(pamixer --default-source --get-mute)" == "true" ]]
}

sound_toggle() {
  if is_mute; then
    pamixer -u && notify
  else
    pamixer -m && notify
  fi
}

notify_mic() {
  if is_mic_mute; then
    notify-send -u low -h string:x-canonical-private-synchronous:volume "Microphone" "Muted"
  else
    local -r volume=$(pamixer --default-source --get-volume)
    notify-send -u low -h string:x-canonical-private-synchronous:volume -h "int:value:$volume" "Microphone" "$volume%"
  fi
}

mic_toggle() {
  if is_mic_mute; then
    pamixer --default-source -u && notify_mic
  else
    pamixer --default-source -m && notify_mic
  fi
}

vol_up() {
  if is_mute; then
    pamixer -u
  else
    pamixer -i "$1" && notify
  fi
}

vol_down() {
  if is_mute; then
    pamixer -u
  else
    pamixer -d "$1" && notify
  fi
}

case "$1" in
"toggle")
  sound_toggle
  ;;
"mic_toggle")
  mic_toggle
  ;;
"mic_up")
  pamixer --default-source -i "$2" && notify_mic
  ;;
"mic_down")
  pamixer --default-source -d "$2" && notify_mic
  ;;
"up")
  vol_up "$2"
  ;;
"down")
  vol_down "$2"
  ;;
esac
