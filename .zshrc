export HOME=/home/cilsat
export DOT=$HOME/.config/dotfiles

# Check for Display
if [ -n "$DISPLAY" ]; then
    # Use a different color scheme for each workspace
    ws=$(wmctrl -d | grep '*' | cut -d ' ' -f14)
    if [ "$ws" = 1 ];then
        BASE16_THEME="$DOT/base16-materiana.sh"
    elif [ "$ws" = 2 ];then
        BASE16_THEME="$HOME/src/base16-shell/scripts/base16-nord.sh"
    elif [ "$ws" = 3 ];then
        BASE16_THEME="$HOME/src/base16-shell/scripts/base16-rebecca.sh"
    elif [ "$ws" = 4 ];then
        BASE16_THEME="$HOME/src/base16-shell/scripts/base16-spacemacs.sh"
    fi
    [[ -s "$BASE16_THEME" ]] && source "$BASE16_THEME"
    # Attach shell to workspace tmux session
    if [[ -z $(tmux ls | egrep $ws": .*attached") ]]; then
        tmux new -As "$ws"
    fi
fi

# Preferred editor for local and remote sessions
if [[ -n "$SSH_CONNECTION" ]]; then
    export EDITOR='vi'
    export DISPLAY=:0
else
    export EDITOR='nvim'
fi

fortune | cowsay

# System environment
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"

# Keys
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
export GNUPGHOME="$HOME/.gnupg"
export GPGKEY=716809DD
export PASSWORD_STORE_DIR="$DOT/.password-store"

# User Path
export PATH="$PATH:$HOME/.local/bin:$HOME/.conda/bin"

# Misc variables
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# Aliases
alias nv="nvim"
alias vim="nvim"
alias pac="pacaur"
alias op="xdg-open"
alias php="php56"

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi
