# Clear screen and set cursor
printf '\33c\e[3J'
echo '\e[3 q' # Blinking block cursor

# Powerlevel10k Instant Prompt (single check)
p10k_cache="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$(print -P "%n").zsh"
[[ -r "$p10k_cache" ]] && source "$p10k_cache"

# Path Variables
export ZDOTDIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
export HISTFILE="$ZDOTDIR/.zsh_history"
export ZSH="$HOME/.config/zsh/oh-my-zsh"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/.local/spicetify:$HOME/.local/gem/ruby/2.6.0/bin"
export PATH="$PATH:$HOME/.local/jetbrains/scripts:$HOME/.local/bin"
export PATH="$PATH:/Users/cheezi/code/scripts/changelog:$HOME/.config/zsh/plugins/swissgit:$HOME/code/scripts"
export PATH=$HOME/.docker/cli-plugins:$PATH
export VIMINIT='source $HOME/.config/vim/vimrc'
export GEM_HOME="$HOME/.local/share/gem"
export NPM_CONFIG_PREFIX="$HOME/.local/share/npm"
export GROOVY_HOME="$HOME/.local/share/groovy"
export GNUPGHOME="$HOME/.local/share/gnupg"
export PATH="/usr/bin:/bin:/usr/local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export HOMEBREW_NO_ENV_HINTS=1

# Set java home to Java 21 if available
if command -v java &>/dev/null; then
    export JAVA_HOME=$(/usr/libexec/java_home -v 17)
fi

# Zsh Options
setopt NO_NOTIFY
unsetopt CHECK_JOBS MONITOR

# Theme and Settings
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE=nerdfont-v3
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Plugins

plugins=(mvn git docker zsh-autocomplete zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Aliases
alias apidocs='http --download GET :8080/api-docs.yaml Accept:application/vnd.oai.openapi;charset=UTF-8'
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias reloadzsh='source ~/.config/zsh/.zshrc'
#alias clear='printf '\''\33c\e[3J'\'
alias cleanfiles='rm ~/Downloads/connect\(*\).rdp ~/Downloads/Personal-xlinsjo\(*\).jnlp'
alias movetoshare="$HOME/.config/zsh/plugins/move_to_share.zsh"
alias sas='mvn clean dept44-formatting:apply generate-sources'
alias fmt='mvn clean dept44-formatting:apply'
compdef '_git' dotfiles

# Custom Scripts
source $HOME/.config/zsh/plugins/catppuccin_frappe-zsh-syntax-highlighting.zsh
#source $HOME/.config/zsh/plugins/.fzf.zsh
[[ -f ~/.config/zsh/p10k.zsh ]] && source ~/.config/zsh/p10k.zsh

# ZPlug installation check and setup
if [[ "$(uname)" == "Darwin" ]]; then
    # macOS path
    export ZPLUG_HOME=/opt/homebrew/opt/zplug
elif [[ "$(uname)" == "Linux" ]]; then
    # Ubuntu path
    export ZPLUG_HOME=$HOME/.zplug
    # Install zplug if not present
    if [[ ! -d $ZPLUG_HOME ]]; then
        echo "Installing zplug..."
        git clone https://github.com/zplug/zplug $ZPLUG_HOME
    fi
fi

# Source zplug only if it exists
if [[ -f $ZPLUG_HOME/init.zsh ]]; then
    source $ZPLUG_HOME/init.zsh
    zplug 'yuhonas/zsh-aliases-lsd'
    zplug check --verbose || zplug install
    zplug load
else
    echo "Warning: zplug not found. Please install zplug first."
fi

# Homebrew completions
if type brew &>/dev/null; then
    export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit && compinit
fi

# FZF Theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

# Terminal title
set_terminal_title() { echo -ne "\033]0;${PWD/#$HOME/~}\007"; }
add-zsh-hook precmd set_terminal_title
