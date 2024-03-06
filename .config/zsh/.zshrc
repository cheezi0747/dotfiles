# Clear screen
printf '\33c\e[3J'
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/zsh/oh-my-zsh"

# Environment Variables
export LESSHISTFILE=-
export HOMEBREW_NO_ENV_HINTS=1
export PATH=/opt/homebrew/bin:$PATH
export PATH=$PATH:$HOME/.local/spicetify
export PATH=$PATH:$HOME/.local/gem/ruby/2.6.0/bin
export PATH=$PATH:$HOME/.local/jetbrains/scripts


# Zsh Options
setopt NO_NOTIFY
unsetopt CHECK_JOBS
unsetopt MONITOR

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Calculate the filename for the p10k instant prompt dynamically
p10k_instant_prompt_file="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$(print -P "%n").zsh"
if [[ -r "$p10k_instant_prompt_file" ]]; then
    source "$p10k_instant_prompt_file"
fi

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE=nerdfont-v3

# Settings
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Plugins
plugins=(mvn git docker zsh-autocomplete zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Custom Aliases
alias apidocs='http --download GET :8080/api-docs.yaml Accept:application/vnd.oai.openapi;charset=UTF-8'ø
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias reloadzsh='source ~/.config/zsh/.zshrc'
alias clear='printf '\''\33c\e[3J'\'
alias cleanfiles='rm ~/Downloads/connect\(*\).rdp ~/Downloads/Personal-xlinsjo\(*\).jnlp'
alias movetoshare="$HOME/.config/zsh/move_to_share.zsh"

compdef '_git' dotfiles

# Source custom scripts
source $HOME/.config/zsh/swissgit/swissgit.sh
source $HOME/.config/zsh/catppuccin_frappe-zsh-syntax-highlighting.zsh

# Powerlevel10k configuration
[[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh

# ZPlug
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug 'yuhonas/zsh-aliases-lsd'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    zplug install
fi
zplug load

# ASDF Version Manager
. /opt/homebrew/opt/asdf/libexec/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit

# Homebrew completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
fi

# Git completions
source $HOME/.config/zsh/swissgit/completions/_swissgit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Set FZF theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

# Function to set the terminal title
set_terminal_title() {
    # If not in SSH, just show the current directory
    echo -ne "\033]0;${PWD/#$HOME/~}\007"
}

# Call set_terminal_title before displaying the prompt
autoload -U add-zsh-hook
add-zsh-hook precmd set_terminal_title
unset ZSH_AUTOSUGGEST_USE_ASYNC
