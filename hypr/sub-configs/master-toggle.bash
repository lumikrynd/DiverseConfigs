#! /usr/bin/env bash

# Script which toggles if the current window is one of the master windows
# It is kind of a hack
# It works by looking at the y-position of the window, and assuming it is
# a master window if it is positioned on the top half of the screen
# (positioned above the 500 pixel mark on the screen, to leave space for
# a menu bar)
# This only works with "top orientation"
#
# I hope a way to get if a windows is master programmatically will be
# made available later.

commandresult=$(hyprctl activewindow -j)
y_pos=$(echo $commandresult | jq '.at[1]')

if ((y_pos < 500)); then
    hyprctl dispatch layoutmsg removemaster
else
    hyprctl dispatch layoutmsg addmaster
fi
