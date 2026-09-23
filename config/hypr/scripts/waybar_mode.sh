#!/bin/bash
# Waybar: docked (reserves space) <-> overlay peek (hidden, shows over windows while SUPER held).
# ponytail: state in files, waybar has no IPC to query its own mode.
STATE=/tmp/waybar-overlay-mode
PEEK=/tmp/waybar-peek-shown

restart() {
  pkill -x waybar
  sleep 0.3
  rm -f "$PEEK"
  if [ -e "$STATE" ]; then
    setsid waybar -c "$HOME/.config/waybar/overlay.jsonc" >/dev/null 2>&1 &
  else
    setsid waybar >/dev/null 2>&1 &
  fi
}

case "$1" in
  restart)
    restart
    ;;
  toggle)
    if [ -e "$STATE" ]; then rm -f "$STATE"; else touch "$STATE"; fi
    restart
    ;;
  show)
    [ -e "$STATE" ] && [ ! -e "$PEEK" ] && touch "$PEEK" && pkill -x -SIGUSR1 waybar
    ;;
  hide)
    [ -e "$PEEK" ] && rm -f "$PEEK" && pkill -x -SIGUSR1 waybar
    ;;
esac
exit 0
