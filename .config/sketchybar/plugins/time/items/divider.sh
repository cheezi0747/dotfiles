#!/usr/bin/env bash
divider=(
	background.color="$SURFACE0"
	background.border_color=0xffF5E3B5
	background.border_width=2
	background.padding_left=10
	background.padding_right
	
)
sketchybar --add bracket timewrapper time time_logo \
	--set timewrapper "${divider[@]}"
