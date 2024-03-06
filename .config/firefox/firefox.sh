#!/bin/bash

PROFILE_FILE="$HOME/Library/Application Support/Firefox/profiles.ini"
PROFILEFOLDER="$HOME/Library/Application Support/Firefox/$(awk -F'=' '/^Path/ && /default-release/ {print $2}' "$PROFILE_FILE")"

echo "Setting up autconfig"
ln -sf $HOME/.config/firefox/autoconfig.js /Applications/Firefox.app/Contents/Resources/defaults/pref/autoconfig.js
ln -sf $HOME/.config/firefox/autoconfig.cfg /Applications/Firefox.app/Contents/Resources/autoconfig.cfg

echo "setting up chrome files"
mkdir "$PROFILEFOLDER/chrome"
ln -s $HOME/.config/firefox/chrome/userChrome.css "$PROFILEFOLDER/chrome/userChrome.css"
ln -s $HOME/.config/firefox/chrome/userContent.css "$PROFILEFOLDER/chrome/userContent.css"
ln -s $HOME/.config/firefox/chrome/shadowfox.css "$PROFILEFOLDER/chrome/shadowfox.css"
ln -s $HOME/.config/firefox/chrome/colors.css "$PROFILEFOLDER/chrome/colors.css"

echo "symlinking user.js"
ln -s $HOME/.config/firefox/user.js "$PROFILEFOLDER/user.js"