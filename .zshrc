# -----------------
# Zsh/ZIM configuration
# -----------------
# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS
# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v
# Prompt for spelling correction of commands.
setopt CORRECT
# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}
# Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes
# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
zstyle ':zim:termtitle' format '%1~'
# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
# Set pac alias
zstyle ':zim:pacman' frontend 'yay'

# Initalize
if [[ ${ZIM_HOME}/init.zsh -ot ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# -----------------
# Home/User configuration
# -----------------
# Set base home paths
export HOME=/home/cilsat
export DOT=$HOME/.config/dotfiles
export BASE16_SHELL="$HOME/src/base16-shell"
export FZF="/usr/share/fzf"

# Check for Display
if [ -n "$DISPLAY" ]; then
    # Use a different color scheme for each workspace
    # xseticon -id $WINDOWID /usr/share/icons/Paper/48x48/apps/utilities-terminal.png
    ws=$(wmctrl -d | grep '*' | cut -d ' ' -f14)
    [ -n "$PS1" ] && \
        [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
            eval "$("$BASE16_SHELL/profile_helper.sh")"
    if [ "$ws" = 1 ];then
        BASE16_THEME="$BASE16_SHELL/scripts/base16-oceanicnext.sh"
    elif [ "$ws" = 2 ];then
        BASE16_THEME="$BASE16_SHELL/scripts/base16-gruvbox-dark-soft.sh"
    elif [ "$ws" = 3 ];then
        BASE16_THEME="$BASE16_SHELL/scripts/base16-ocean.sh"
    elif [ "$ws" = 4 ];then
        BASE16_THEME="$BASE16_SHELL/scripts/base16-materia.sh"
    fi
    [[ -s "$BASE16_THEME" ]] && source "$BASE16_THEME"
    # Attach shell to workspace tmux session and force unicode
    if [[ -z $(tmux ls | egrep $ws": .*attached") ]]; then
        tmux -u new -As "$ws"
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
export PATH="$HOME/.local/bin:$PATH:$HOME/.config/composer/vendor/bin:\
$HOME/.local/share/go/bin"

# Misc variables
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "
source "$FZF/completion.zsh"
source "$FZF/key-bindings.zsh"
export FZF_COMPLETION_TRIGGER="**"
export FZF_DEFAULT_OPTS="--height 50% --preview=\"less {}\" \
  --preview-window=right:50%:hidden --cycle --multi \
  --bind=?:toggle-preview --bind=tab:down --bind=btab:up --bind=space:toggle \
  --bind=ctrl-d:half-page-down --bind=ctrl-u:half-page-up"
export FZF_DEFAULT_COMMAND="fd -i -H -I -F -L -E \".git\" -E \"node_modules\""

_fzf_compgen_path() {
  fd -i -H -I -F -L -E ".git" -E "node_modules" . "$1"
}

# Aliases
alias nv="nvim"
alias pnv="poetry run nvim"
alias sc="sudo systemctl"
alias op="xdg-open"
