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
        BASE16_THEME="$DOT/base16-rebecca.sh"
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
export EDITOR='nvim'
if [[ -n "$SSH_CONNECTION" ]]; then
    export DISPLAY=:0
fi

fortune | cowsay

# System environment
export LD_LIBRARY_PATH="/opt/OpenBLAS/lib:/opt/cuda/lib64: \
  /opt/cuda/extras/CUPTI/lib64:$HOME/.local/lib:$LD_LIBRARY_PATH"
export PATH="$HOME/.local/bin:$PATH:$HOME/.config/composer/vendor/bin:$HOME/.conda/bin"

# Keys
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
export GNUPGHOME="$HOME/.gnupg"
export GPGKEY=716809DD
export PASSWORD_STORE_DIR="$DOT/.password-store"

# User Path
# Path to composer bin needed for vim php completion: composer global require
# mkusher/padawan, padawan generate in project dir
export PATH="$HOME/.local/bin:$PATH:$HOME/.config/composer/vendor/bin:$HOME/.conda/bin"

# Misc variables
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# Aliases
alias nv="nvim"
alias pac="pacaur"
alias op="xdg-open"

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi
