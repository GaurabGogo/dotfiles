#!/bin/bash

wal -R &
~/dotfiles/scripts/set_last_wallpaper.sh &
spotify &
blueman-applet &
nm-applet &
flameshot &
xscreensaver --no-splash &
copyq &
volumeicon &
thunderbird &
redshift &
xfce4-power-manager &
picom --config ~/.config/picom/picom.conf &

