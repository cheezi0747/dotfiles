#!/usr/bin/env bash
#

divider=(
	background.color="$SURFACE0"
	background.border_color=0xff92B3F5
	background.border_width=2
	background.border_width=2
)
sketchybar --add bracket datewrapper date date_logo \
	--set datewrapper "${divider[@]}"
