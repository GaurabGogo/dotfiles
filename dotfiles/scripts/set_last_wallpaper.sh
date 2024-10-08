#!/bin/bash

# File where the last wallpaper is stored
LAST_WALLPAPER_FILE="$HOME/.last_wallpaper"

# Check if the last wallpaper file exists and set the wallpaper
if [ -f "$LAST_WALLPAPER_FILE" ]; then
    feh --bg-scale "$(cat "$LAST_WALLPAPER_FILE")"
fi

