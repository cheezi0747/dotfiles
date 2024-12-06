#!/bin/bash

# Fail immediately if a command exits with a non-zero status
set -e

# Clone the dotfiles repository
clone_dotfiles_repo() {
    echo "Cloning dotfiles repository..."
    git clone --bare https://github.com/cheezi0747/dotfiles.git $HOME/.dotfiles
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
    echo "Dotfiles repository cloned and checked out."
    # Set up Zsh configuration directory after cloning
    echo "Setting up Zsh configuration directory..."
    echo export ZDOTDIR=~/.config/zsh | sudo tee -a /etc/zshenv
}

# Install xCode CLI tools
install_xcode() {
    echo "Checking Command Line Tools for Xcode"
    # Only run if the tools are not installed yet
    if ! xcode-select -p &>/dev/null; then
        echo "Command Line Tools for Xcode not found. Installing from softwareupdate…"
        # This temporary file prompts the 'softwareupdate' utility to list the Command Line Tools
        touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
        PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
        if [ -n "$PROD" ]; then
            softwareupdate -i "$PROD" --verbose
            echo "Command Line Tools for Xcode installed successfully."
        else
            echo "No Command Line Tools found for installation. Please check your internet connection or try manually."
        fi
        rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    else
        echo "Command Line Tools for Xcode have been installed."
    fi
}

# Install Oh My Zsh and plugins
install_oh_my_zsh() {
    echo "Installing Oh My Zsh..."
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        ZSH="$HOME/.config/zsh/oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        echo "Oh My Zsh already installed."
    fi

    # Install Powerlevel10k
    echo "Installing Powerlevel10k..."
    local theme_dir="$HOME/.config/zsh/oh-my-zsh/custom/themes/powerlevel10k"
    if [ ! -d "$theme_dir" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$theme_dir"
    else
        echo "Powerlevel10k already installed."
    fi

    # Install ZSH Autosuggestions
    echo "Installing ZSH Autosuggestions..."
    local autosuggestions_dir="$HOME/.config/zsh/oh-my-zsh/custom/plugins/zsh-autosuggestions"
    if [ ! -d "$autosuggestions_dir" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "$autosuggestions_dir"
    else
        echo "ZSH Autosuggestions already installed."
    fi

    # Install ZSH Syntax Highlighting
    echo "Installing ZSH Syntax Highlighting..."
    local syntax_dir="$HOME/.config/zsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    if [ ! -d "$syntax_dir" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$syntax_dir"
    else
        echo "ZSH Syntax Highlighting already installed."
    fi

    # Reload Zsh configuration
    echo "Reloading Zsh configuration..."
    source $HOME/.config/zsh/.zshrc
}

# Install Brew
install_brew() {
    echo "Installing Homebrew..."
    if ! command -v brew &>/dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew already installed."
    fi
}

# Install Swissgit
install_swissgit() {
    echo "Installing Swissgit..."
    local swissgit_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/swissgit"
    if [ ! -d "$swissgit_dir" ]; then
        git clone https://github.com/CheeziCrew/Swissgit.git "$swissgit_dir"
    else
        echo "Swissgit already installed."
    fi
}

# Set macOS Defaults
set_macos_defaults() {
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
    echo "macOS defaults have been set."
}

# Setup Firefox
setup_firefox() {
    echo "Setting up Firefox"
    $HOME/.config/firefox/firefox.sh
}

# Setup Spicetify
setup_spicetify() {
    echo "Setting up Spotify with Spicetify"
    $HOME/.config/spicetify/spicetify.sh
}

# Install Homebrew Packages
install_homebrew_packages() {
    echo "Installing Homebrew packages"
    brew bundle --file $HOME/.config/homebrew/Brewfile
}

# Set Wallpaper
set_wallpaper() {
    echo "Setting wallpaper to Grid Magenta..."
    osascript -e 'tell application "System Events" to set picture of every desktop to POSIX file "/System/Library/Desktop Pictures/Grid Magenta.madesktop"'
    echo "Wallpaper has been set to Grid Magenta."
}

# Main
install_xcode
clone_dotfiles_repo
install_oh_my_zsh
install_brew
install_homebrew_packages
install_swissgit
set_macos_defaults
setup_firefox
setup_spicetify
set_wallpaper

echo "All installations and configurations are complete!"
