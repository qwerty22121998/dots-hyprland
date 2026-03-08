#!/bin/bash

BASE_PATH="/usr/share/sounds/freedesktop/stereo/"

play_sound() {
  paplay "${BASE_PATH}$1.oga"

}

play_sound "$1"
