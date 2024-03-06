#!/usr/bin/env bash
#

divider=(
	background.color="$SURFACE0"
	background.border_color=0xffE0A3AD
	background.border_width=2
	width=200
)
sketchybar --add bracket wifiwrapper network.down network.up wifi.alias \
	--set wifiwrapper "${divider[@]}"
