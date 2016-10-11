# Path to oh-my-zsh installation.
export HOME=/home/cilsat
export ZSH=$HOME/.oh-my-zsh

# oh-my-zsh settings
ZSH_THEME=ys
DEFAULT_USER="cilsat"
ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd/mm/yyyy"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_AUTO_TITLE="true"

plugins=(colored-man-pages command-not-found git-fast ssh-agent zsh-syntax-highlighting)

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets root line)

# Check for Display
if [ -n "$DISPLAY" ]; then
    # Uses special symbols
    ZSH_THEME=agnoster
    # Use a different color scheme for each workspace
    ws=$(wmctrl -d | grep '*' | cut -d ' ' -f14)
    if [ "$ws" = 1 ];then
        BASE16_THEME="$HOME/src/base16-shell/scripts/base16-materia.sh"
    elif [ "$ws" = 2 ];then
        BASE16_THEME="$HOME/src/base16-shell/scripts/base16-dracula.dark.sh"
    elif [ "$ws" = 3 ];then
        BASE16_THEME="$HOME/src/base16-shell/scripts/base16-spacemacs.sh"
    elif [ "$ws" = 4 ];then
        BASE16_THEME="$HOME/src/base16-shell/scripts/base16-apathy.sh"
    fi
    [[ -s $BASE16_THEME ]] && source $BASE16_THEME
    # Resume workspace session in workspace terminals.
    # If session already attached then open normal terminal.
    a=": .*attached"
    if [[ -z $(tmux ls | egrep $ws$a) ]]; then
        tmux new -A -s $ws
    fi
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
    #export TERM=screen-256color
else
    export EDITOR='nvim'
    #export TERM=screen-256color
fi

# System environment
# export ARCHFLAGS="-arch x86_64"
export OMP_THREAD_LIMIT=4
export LD_LIBRARY_PATH=/opt/OpenBLAS/lib:$HOME/.local/lib:$LD_LIBRARY_PATH
#export LANG=en_US.UTF-8

# Keys
export SSH_KEY_PATH="~/.ssh/rsa_id"
export GNUPGHOME="~/.config/gnupg"
export GPGKEY=716809DD

# Python virtualenvs
#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/dev
#source /usr/local/bin/virtualenvwrapper_lazy.sh

# User Path
export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.conda/bin"

# Aliases
alias nv="nvim"
alias loc="locate"

source $ZSH/oh-my-zsh.sh
