#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/Wallpaper/hd/"
# File to store the last wallpaper
LAST_WALLPAPER_FILE="$HOME/.last_wallpaper"

# Select a random wallpaper
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Set the wallpaper (using feh)
feh --bg-scale "$WALLPAPER"

# Generate colors using pywal
wal -i "$WALLPAPER"

# Save the last wallpaper to a file
echo "$WALLPAPER" > "$LAST_WALLPAPER_FILE"

