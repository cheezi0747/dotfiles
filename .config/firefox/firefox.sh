#!/bin/bash

# Download the latest Firefox installer page
response=$(curl -s https://download.mozilla.org/\?product\=firefox-latest-ssl\&os\=osx\&lang\=en-US)

# Extract the download URL from the response
url=$(echo $response | grep -o 'https://download-installer.cdn.mozilla.net/pub/firefox/releases/[0-9.]*/mac/en-US/Firefox%20[0-9.]*.dmg')

# Download the Firefox DMG file
curl -L $url -o firefox.dmg

# Mount the DMG file
hdiutil attach firefox.dmg

# Copy Firefox to the Applications folder
cp -r /Volumes/Firefox/Firefox.app /Applications

# Unmount the DMG file
hdiutil detach /Volumes/Firefox

PROFILE_FILE="$HOME/Library/Application Support/Firefox/profiles.ini"
PROFILEFOLDER="$HOME/Library/Application Support/Firefox/$(awk -F'=' '/^Path/ && /default-release/ {print $2}' "$PROFILE_FILE")"

echo "Setting up autconfig"
# Create the necessary directories
mkdir -p /Applications/Firefox.app/Contents/Resources/defaults/pref
ln -sf $HOME/.config/firefox/autoconfig.js /Applications/Firefox.app/Contents/Resources/defaults/pref/autoconfig.js
ln -sf $HOME/.config/firefox/autoconfig.cfg /Applications/Firefox.app/Contents/Resources/autoconfig.cfg

echo "setting up chrome files"
mkdir -p "$PROFILEFOLDER/chrome"
ln -s $HOME/.config/firefox/chrome/userChrome.css "$PROFILEFOLDER/chrome/userChrome.css"
ln -s $HOME/.config/firefox/chrome/userContent.css "$PROFILEFOLDER/chrome/userContent.css"
ln -s $HOME/.config/firefox/chrome/shadowfox.css "$PROFILEFOLDER/chrome/shadowfox.css"
ln -s $HOME/.config/firefox/chrome/colors.css "$PROFILEFOLDER/chrome/colors.css"

echo "symlinking user.js"
ln -s $HOME/.config/firefox/user.js "$PROFILEFOLDER/user.js"
