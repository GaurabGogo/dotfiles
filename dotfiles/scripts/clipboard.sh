#!/bin/bash

# Temporary file to store clipboard history
history_file="$HOME/.clipboard_history"

# Create the history file if it doesn't exist
touch "$history_file"

# Get the current clipboard contents and its mime type
clipboard_content=$(xclip -o -selection clipboard 2>/dev/null)
mime_type=$(xclip -o -selection clipboard -t TARGETS 2>/dev/null | grep -E 'text/')

# Check if clipboard is empty and if it's text
if [ -n "$clipboard_content" ] && [ -n "$mime_type" ]; then
  # Add the current clipboard content to the history if it's not already there
  if ! grep -Fxq "$clipboard_content" "$history_file"; then
    # Prepend the new entry to the history file
    echo "$clipboard_content" | cat - "$history_file" > "$history_file.tmp" && mv "$history_file.tmp" "$history_file"
  fi
fi

# Keep only the last 10 unique entries
awk '!seen[$0]++' "$history_file" | head -n 10 > "$history_file.tmp" && mv "$history_file.tmp" "$history_file"

# Add clear option
clear_option="Clear Clipboard"

# Prepare the list for rofi
list_items=$(cat "$history_file" | sed '/^$/d' | awk '{print NR": "$0}') # Add line numbers

# Include the clear option
list_items=$(echo -e "$list_items\n$clear_option")

# Use rofi to display the list
selected_item=$(echo -e "$list_items" | rofi -dmenu -p "Select an item:")

# Check what was selected
if [ "$selected_item" == "$clear_option" ]; then
  # Clear the clipboard
  xclip -i /dev/null -selection clipboard
  # Clear all history entries
  > "$history_file"
  echo "Clipboard cleared and history emptied."
elif [ -n "$selected_item" ]; then
  # Extract the selected item by removing line number
  selected_index=$(echo "$selected_item" | cut -d':' -f1)
  selected_text=$(sed -n "${selected_index}p" "$history_file")
  
  # Yank the selected item back to clipboard
  echo -n "$selected_text" | xclip -selection clipboard
  echo "Yanked to clipboard: $selected_text"
else
  echo "No item selected."
fi

