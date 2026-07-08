#!/bin/bash

CURRENT_WALLPAPER="$HOME/Pictures/Wallpapers/_current_wallpaper"

magick $CURRENT_WALLPAPER -gravity center -crop 1:1 square.jpg
