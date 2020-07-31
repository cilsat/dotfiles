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
export DEFAULT_USER=cil.satriawan
export HOME=/home/$DEFAULT_USER
export DOT=$HOME/.config/dotfiles
export BASE16_SHELL="$HOME/src/base16-shell"
export FZF="$HOME/.fzf/shell"

# Check for Display
if [ -n "$DISPLAY" ]; then
    # Use a different color scheme for each workspace
    ws=$(wmctrl -d | grep '*' | cut -d ' ' -f14)
    if [ "$ws" = 1 ];then
        BASE16_THEME="$BASE16_SHELL/scripts/base16-ocean.sh"
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

#fortune -s | cowsay

# System environment
export LD_LIBRARY_PATH="/opt/OpenBLAS/lib:/opt/cuda/lib64:\
/opt/cuda/extras/CUPTI/lib64:$HOME/.local/lib:$LD_LIBRARY_PATH"

# Keys
export SSH_ASKPASS="ksshaskpass"
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
export GNUPGHOME="$HOME/.gnupg"
export GPGKEY=716809DD
export PASSWORD_STORE_DIR="$HOME/.password-store"

#-1 User environment
# Path needs to include composer and go bin paths
export PATH="$HOME/.local/bin:$PATH:$HOME/.config/composer/vendor/bin:\
$HOME/.local/share/go/bin"
export LIBVA_DRIVER_NAME=iHD
# Go path
export GOPATH="$HOME/.local/share/go"
# Python
export PYENV_ROOT="$HOME/.pyenv"
export POETRY_ROOT="$HOME/.poetry"
# PATH
export PATH="$HOME/.local/bin:$PATH:$HOME/.config/composer/vendor/bin:\
$HOME/.local/share/go/bin:$PYENV_ROOT/bin:$POETRY_ROOT/bin"

eval "$(pyenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source "$FZF/completion.zsh"
source "$FZF/key-bindings.zsh"
export FZF_COMPLETION_TRIGGER="**"
export FZF_DEFAULT_OPTS="--height 50% --preview=\"less {}\" \
  --preview-window=right:30%:hidden --cycle --multi \
  --bind=?:toggle-preview --bind=tab:down --bind=btab:up --bind=space:toggle \
  --bind=ctrl-d:half-page-down --bind=ctrl-u:half-page-up \
  --color fg:7,bg:-1,hl:6,fg+:7,bg+:18,hl+:3 \
  --color info:8,prompt:5,spinner:15,pointer:16,marker:3"
export FZF_DEFAULT_COMMAND="fd -i -H -I -F -L -E \".git\" -E \"node_modules\""
_fzf_compgen_path() {
  fd -i -H -I -F -L -E ".git" -E "node_modules" . "$1"
}

# Aliases
alias nv="nvim"
alias pnv="poetry run nvim"
alias sc="sudo systemctl"
alias op="xdg-open"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
