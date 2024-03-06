#!/usr/bin/env bash

source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/colors.sh"

network_down=(
	icon.padding_left=5
	icon.padding_right=0
	background.padding_left=-10
	label.padding_left=5
	label.padding_right=5
	background.padding_right=20
	y_offset=-7
	label.font="$FONT:Heavy:10"
	label.color="$TEXT"
	icon="$NETWORK_DOWN"
	icon.font="$NERD_FONT:Bold:16.0"
	icon.color="$GREEN"
	icon.highlight_color="$BLUE"
	update_freq=1
)

network_up=(
	icon.padding_left=5
	icon.padding_right=0
	background.padding_left=5
	label.padding_left=5
	label.padding_right=5
	background.padding_right=-60
	y_offset=7
	label.font="$FONT:Heavy:10"
	label.color="$TEXT"
	icon="$NETWORK_UP"
	icon.font="$NERD_FONT:Bold:16.0"
	icon.color="$GREEN"
	icon.highlight_color="$BLUE"
	update_freq=1
	script="$PLUGIN_DIR/wifi/scripts/network.sh"
)

sketchybar --add item network.down right \
	--set network.down "${network_down[@]}" \
	--add item network.up right \
	--set network.up "${network_up[@]}"
