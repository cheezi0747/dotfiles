# Install xCode cli tools
echo "Installing commandline tools..."
xcode-select --install

#Install Oh My ZSh and plugins
echo "Installing Oh My ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv .zshrc.pre-oh-my-zsh .zshrc

echo "Installing Powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.config/zsh/oh-my-zsh/custom}/themes/powerlevel10k

echo "Installing ZSH Autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.config/zsh/oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Installing ZSH Syntax Highlightning"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.config/zsh/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Installing swissgit"
git clone https://github.com/CheeziCrew/Swissgit.git ${ZSH_CUSTOM:-$HOME/.config/zsh/swissgit}

echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

#Install Homebrew packages
echo "Installing Homebrew packages"
brew bundle --file $HOME/.config/homebrew/Brewfile

echo "install sketchybar fonts"
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.5/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

#Setup Firefox
echo "Setting up Firefox"
$HOME/.config/firefox/firefox.sh

#Setup Spicetfiy
echo "Setting up Spotify with Spicetify"
$HOME/.config/spicetify/spicetify.sh

# macOS Settings
echo "Changing macOS defaults..."
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.spaces spans-displays -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock "mru-spaces" -bool "false"
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults write NSGlobalDomain AppleHighlightColor -string "181 76 124"
defaults write NSGlobalDomain AppleAccentColor -int 6
defaults write com.apple.screencapture location -string "$HOME/Desktop"
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.Finder AppleShowAllFiles -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder ShowStatusBar -bool false
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool YES
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

#Set wallpaper
echo "Setting Wallpaper"
osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"/Users/cheezi-home/Pictures/apple-colors-big-4k-frappe.png\" as POSIX file"

#Start things
echo "Starting Services (grant permissions)..."
yabai --start-service
skhd --start-service
brew services start sketchybar

echo "Add sudoer manually:\n '$(whoami) ALL = (root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | awk "{print \$1;}") $(which yabai) --load-sa' to '/private/etc/sudoers.d/yabai'"
