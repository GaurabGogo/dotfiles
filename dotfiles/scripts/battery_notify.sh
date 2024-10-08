#!/bin/bash

# Get the battery percentage
battery_percentage=$(acpi -b | grep -P -o '[0-9]+(?=%)')

# Check if the battery percentage is below 10
if [ "$battery_percentage" -lt 10 ]; then
    notify-send "Battery Low" "Your battery is below 10%! Please charge your device."
fi

