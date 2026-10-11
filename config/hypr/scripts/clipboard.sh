#!/bin/bash

ROFI_CONFIG=$HOME/.config/hypr/scripts/rofi_choose.rasi
THUMB_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/cliphist/thumbs"
IMG_RE='^\[\[ binary data .* (png|jpe?g|gif|bmp|webp) '

mkdir -p "$THUMB_DIR"
entries=$(cliphist list)

# drop thumbnails whose entry is gone (deleted, wiped or aged out)
for thumb in "$THUMB_DIR"/*; do
  id=${thumb##*/}
  grep -q "^${id%.*}"$'\t' <<<"$entries" || rm -f "$thumb"
done

# image entries get their decoded file as the row icon
rows() {
  while IFS=$'\t' read -r id preview; do
    if [[ $preview =~ $IMG_RE ]]; then
      thumb="$THUMB_DIR/$id.${BASH_REMATCH[1]}"
      [[ -s $thumb ]] || cliphist decode "$id" >"$thumb"
      printf '%s\t%s\0icon\x1f%s\n' "$id" "$preview" "$thumb"
    else
      printf '%s\t%s\n' "$id" "$preview"
    fi
  done <<<"$entries"
}

selected=$(rows |
  rofi -dmenu -i -config "$ROFI_CONFIG" -display-columns 2 -mesg "󰅌 Clipboard" -p "Clipboard" \
    -theme-str 'element-icon { size: 4em; } listview { lines: 6; }')

# a cancelled picker prints nothing; piping that on would blank the clipboard
if [[ -n $selected ]]; then
  cliphist decode <<<"$selected" | wl-copy
fi
