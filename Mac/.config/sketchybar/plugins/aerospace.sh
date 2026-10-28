#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

OCCUPIED_WORKSPACES=$(aerospace list-workspaces --monitor focused --empty no)
IS_OCCUPIED=$(echo "$OCCUPIED_WORKSPACES" | grep -F -w "$1")
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    # Highlights the currently focused workspace
    sketchybar --set "$NAME" background.drawing=on drawing=on
elif [ -n "$IS_OCCUPIED" ]; then
    # Shows occupied but unfocused workspaces (without background highlight)
    sketchybar --set "$NAME" background.drawing=off drawing=on
else
    # Completely hides empty and inactive workspaces
    sketchybar --set "$NAME" drawing=off
fi

