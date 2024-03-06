#!/usr/bin/env bash
#

divider=(
	background.color="$SURFACE0"
	background.border_color=0xffa6da95
	background.border_width=2
)
sketchybar --add bracket batterywrapper battery battery_logo \
	--set batterywrapper "${divider[@]}"
