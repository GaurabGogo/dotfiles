#!/bin/bash

# Define the available themes
themes=(
    "blocks"
    "colorblocks"
    "cuts"
    "docky"
    "forest"
    "grayblocks"
    "hack"
    "material"
    "panels"
    "pwidgets"
    "shades"
    "shapes"
)

# Use rofi to display the themes and get the selected theme
selected_theme=$(printf '%s\n' "${themes[@]}" | rofi -dmenu -p "Select Polybar Theme:")

# Check if a theme was selected
if [ -n "$selected_theme" ]; then
    # Run the launch script with the selected theme
    bash ~/.config/polybar/launch.sh --"$selected_theme"
else
    echo "No theme selected."
fi

