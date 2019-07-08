# Change default zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh
export HOME=/home/cilsat
export DOT=$HOME/.config/dotfiles
export BASE16_SHELL="$HOME/src/base16/base16-shell"

# Check for Display
if [ -n "$DISPLAY" ]; then
    # Use a different color scheme for each workspace
    # xseticon -id $WINDOWID /usr/share/icons/Paper/48x48/apps/utilities-terminal.png
    ws=$(wmctrl -d | grep '*' | cut -d ' ' -f14)
    [ -n "$PS1" ] && \
        [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
            eval "$("$BASE16_SHELL/profile_helper.sh")"
    if [ "$ws" = 1 ];then
        BASE16_THEME="$BASE16_SHELL/scripts/base16-oceanicnext-dusk.sh"
    elif [ "$ws" = 2 ];then
        BASE16_THEME="$BASE16_SHELL/scripts/base16-gruvbox-dark-soft.sh"
    elif [ "$ws" = 3 ];then
        BASE16_THEME="$BASE16_SHELL/scripts/base16-ocean.sh"
    elif [ "$ws" = 4 ];then
        BASE16_THEME="$BASE16_SHELL/scripts/base16-materia.sh"
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

fortune -s | cowsay

# System environment
export LD_LIBRARY_PATH="/opt/OpenBLAS/lib:/opt/cuda/lib64:\
/opt/cuda/extras/CUPTI/lib64:$HOME/.local/lib:$LD_LIBRARY_PATH"

# Keys
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
export GNUPGHOME="$HOME/.gnupg"
export GPGKEY=716809DD
export PASSWORD_STORE_DIR="$HOME/.password-store"
# For kwallet ssh integration
export SSH_ASKPASS="ksshaskpass"

# User environment
# Go path
export GOPATH="$HOME/.local/share/go"
# PyEnv
export PYENV_ROOT="$HOME/.local/share/pyenv"
eval "$(pyenv init -)"
# Path to composer bin needed for vim php completion: composer global require
# mkusher/padawan, padawan generate in project dir
export PATH="$HOME/.local/bin::$PATH:$HOME/.config/composer/vendor/bin:\
  $HOME/.local/share/go/bin"

# Misc variables
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# Aliases
alias nv="nvim"
alias pac="yay"
alias op="xdg-open"
alias sc="sudo systemctl"

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/cilsat/.local/share/conda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/cilsat/.local/share/conda/etc/profile.d/conda.sh" ]; then
#        . "/home/cilsat/.local/share/conda/etc/profile.d/conda.sh"
#    else
#        export PATH="$PATH:/home/cilsat/.local/share/conda/bin"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<
