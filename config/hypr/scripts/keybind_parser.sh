#!/bin/bash

ROFI_CONFIG=$HOME/.config/hypr/scripts/rofi_choose.rasi

hyprctl binds -j |
  jq -r '
    # modmask is a bitfield; decode it so any combination gets named
    def mods: . as $m | [[64, "SUPER"], [4, "CTRL"], [8, "ALT"], [1, "SHIFT"]]
      | map(select(($m / .[0] | floor) % 2 == 1) | .[1]);
    sort_by(.modmask)[] | ((.modmask | mods) + [.key] | join("+")) + " : " + (.description // "")' |
  rofi -dmenu -i -config "$ROFI_CONFIG" -mesg "󰌓 Keybinds" -p "Search keybinds"
