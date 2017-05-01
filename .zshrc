# Path to oh-my-zsh installation.
export HOME=/home/cilsat
export DOT=$HOME/.config/dotfiles
export ZSH=$HOME/.oh-my-zsh

# oh-my-zsh settings
ZSH_THEME="ys"
DEFAULT_USER="cilsat"
ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd/mm/yyyy"

plugins=(colored-man-pages command-not-found git-fast ssh-agent zsh-syntax-highlighting)

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets root line)

# Check for Display
if [ -n "$DISPLAY" ]; then
    # Uses special symbols
    #ZSH_THEME="agnoster"
    # Use a different color scheme for each workspace
    ws=$(wmctrl -d | grep '*' | cut -d ' ' -f14)
    if [ "$ws" = 1 ];then
        BASE16_THEME="$HOME/src/base16-shell/scripts/base16-ocean.sh"
    elif [ "$ws" = 2 ];then
        BASE16_THEME="$HOME/src/base16-shell/scripts/base16-oceanicnext.sh"
    elif [ "$ws" = 3 ];then
        BASE16_THEME="$HOME/src/base16-shell/scripts/base16-paraiso.sh"
    elif [ "$ws" = 4 ];then
        BASE16_THEME="$HOME/src/base16-shell/scripts/base16-railscasts.sh"
    fi
    [[ -s "$BASE16_THEME" ]] && source "$BASE16_THEME"
    # Attach shell to workspace tmux session
    if [[ -z $(tmux ls | egrep $ws": .*attached") ]]; then
        systemd-run --scope --user tmux new -As "$ws"
    fi
fi

# Preferred editor for local and remote sessions
if [[ -n "$SSH_CONNECTION" ]]; then
    export EDITOR='vi'
    export DISPLAY=:0
else
    export EDITOR='nvim'
fi

fortune -e fortunes | cowsay

# System environment
export LD_LIBRARY_PATH="/opt/OpenBLAS/lib:$HOME/.local/lib:$LD_LIBRARY_PATH"

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

source "$ZSH/oh-my-zsh.sh"

# FZF settings and key bindings. Must be sourced *after* oh-my-zsh
if [ -d /usr/share/fzf ]; then
    export FZF_DIR=$HOME/.config/fzf
    source "/usr/share/fzf/key-bindings.zsh"
    source $FZF_DIR/completion.zsh

    [ ! -d $FZF_DIR ] && mkdir -p $FZF_CACHE
    export FZF_DEFAULT_COMMAND='ag --hidden --silent \
      -p $FZF_DIR/ignore -fg "" / | tee $FZF_DIR/db'
    export FZF_DEFAULT_OPTS='--reverse --border --bind=ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-f:page-down,ctrl-b:page-up'
    export FZF_CTRL_T_COMMAND='<$FZF_DIR/db'
    export FZF_COMPLETION_TRIGGER='*'

    _fzf_compgen_path() {
        ag --nobreak --nonumbers "$1" $FZF_DIR/db
    }
fi
