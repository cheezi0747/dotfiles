#!/usr/bin/env bash
#

divider=(
	background.color="$SURFACE0"
	background.border_color="$WHITE"
	background.border_width=2
)
sketchybar --add bracket githubwrapper github.bell github.label  \
	--set githubwrapper "${divider[@]}"
