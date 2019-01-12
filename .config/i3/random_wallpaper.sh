#!/bin/bash

WALLPAPER_DIR="$HOME/.config/i3/wallpaper"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf | tail -n 1)
echo "$WALLPAPER"
notify-send "$WALLPAPER"
feh --bg-fill "$WALLPAPER"
