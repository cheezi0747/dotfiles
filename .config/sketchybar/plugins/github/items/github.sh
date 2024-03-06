#!/usr/bin/env bash

POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

github_bell=(
	update_freq=30
	icon.font="$FONT:Bold:15.0"
	icon="$BELL"
	icon.color="$BLUE"
	background.color="$WHITE"
	label.drawing=off
	background.border_color="$WHITE"
	background.border_width=2
    background.padding_left=0
	popup.align=right
	script="$PLUGIN_DIR/github/scripts/github.sh"
	click_script="$POPUP_CLICK_SCRIPT"
)

github_label=(
	label.padding_left=-10
    background.padding_left=-10
	label="$LOADING"
	label.highlight_color="$BLUE"
)

github_template=(
	drawing=off
	background.corner_radius=8
	background.padding_left=7
	background.padding_right=7
	icon.background.height=2
	icon.background.y_offset=-12
)

sketchybar --add item github.label right \
	--set github.label "${github_label[@]}" \
	--add item github.bell right \
	--set github.bell "${github_bell[@]}" \
	--subscribe github.bell mouse.entered \ mouse.exited \ mouse.exited.global \
	--add item github.template popup.github.bell \
	--set github.template "${github_template[@]}"
