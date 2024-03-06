#!/bin/bash

time_logo=(
    icon=
    icon.color=0xff121219
    label.drawing=off
    label.padding_left=0
    label.padding_right=0
    background.padding_left=0
    background.padding_right=0
    background.color=0xffF5E3B5
)

sketchybar --add item time_logo right \
    --set time_logo "${time_logo[@]}"
