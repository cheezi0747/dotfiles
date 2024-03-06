date=(
    update_freq=1000
    icon.drawing=off
   	label.padding_left=0
    script="$PLUGIN_DIR/date/scripts/date.sh"
)

sketchybar --add item date right \
    --set date "${date[@]}" \