battery=(
    update_freq=3
    icon.drawing=off
    label.padding_left=0
    label.padding_right=0
    background.padding_left=0
    script="$PLUGIN_DIR/battery/scripts/battery.sh"
)

sketchybar --add item battery right \
    --set battery "${battery[@]}"