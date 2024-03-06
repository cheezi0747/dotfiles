#!/usr/bin/env bash

# Read the value of AppleCurrentKeyboardLayoutInputSourceID
keyboard_layout=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)


# Check the value and set the variable locale accordingly
if [[ $keyboard_layout == "com.apple.keylayout.ABC" ]]; then
    locale="US"
    bgcolor=0xffE0A3AD
elif [[ $keyboard_layout == "com.apple.keylayout.Swedish-Pro" ]]; then
    locale="SE"
    bgcolor=0xff5e81ac
else
    locale="?"
fi

# Set the label of the Sketchybar to the determined locale value
sketchybar --set locale_logo icon="${locale}"
sketchybar --set locale_logo background.color="${bgcolor}"
