#!/bin/bash

WALLPAPER_DIR="$HOME/Dropbox/useful/config/wallpaper"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf | tail -n 1)
echo "$WALLPAPER"
notify-send "$WALLPAPER"
feh --bg-fill "$WALLPAPER"
