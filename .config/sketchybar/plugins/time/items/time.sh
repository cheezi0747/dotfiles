#!/bin/bash
time=(
    icon.drawing=off
    script="$PLUGIN_DIR/time/scripts/time.sh"
    update_freq=1
    label.width=55
    width=60
)

sketchybar --add item time right \
    --set time "${time[@]}"
