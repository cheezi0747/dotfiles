#!/bin/bash

locale_logo=(
    icon.color=0xff121219
    label.drawing=off
    background.color=0xffF5E3B5
    script="$PLUGIN_DIR/locale/scripts/locale.sh"
    update_freq=1
)

sketchybar --add item locale_logo right \
    --set locale_logo "${locale_logo[@]}"
