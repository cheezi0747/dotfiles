#!/bin/bash

battery_logo=(
    icon=""
    icon.color=0xff121219
    label.drawing=off
    label.padding_left=0
    label.padding_right=0
    background.padding_left=0
    background.color=0xffa6da95
)

sketchybar --add item battery_logo right \
    --set battery_logo "${battery_logo[@]}"
