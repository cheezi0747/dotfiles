#!/bin/sh

DESIRED_SPACES_PER_DISPLAY=7
# Query displays and their spaces, extracting both display ID and spaces
DISPLAYS_AND_SPACES="$(yabai -m query --displays | jq -r '.[] | "\(.index) \(.spaces | @sh)"')"

while read -r display spaces; do
  LAST_SPACE="$(echo "${spaces##* }")"
  EXISTING_SPACE_COUNT="$(echo "$spaces" | wc -w)"
  MISSING_SPACES=$(($DESIRED_SPACES_PER_DISPLAY - $EXISTING_SPACE_COUNT))
  if [ "$MISSING_SPACES" -gt 0 ]; then
    for i in $(seq 1 $MISSING_SPACES); do
      # Focus on the correct display before creating a space
      yabai -m display --focus $display
      yabai -m space --create
      LAST_SPACE=$(($LAST_SPACE+1))
    done
  elif [ "$MISSING_SPACES" -lt 0 ]; then
    for i in $(seq 1 $((-$MISSING_SPACES))); do

      # Focus on the correct display before destroying a space
      yabai -m display --focus $display
      yabai -m space --destroy $LAST_SPACE
      LAST_SPACE=$(($LAST_SPACE-1))
    done
  fi
done <<< "$DISPLAYS_AND_SPACES"


sketchybar --trigger space_change --trigger windows_on_spaces