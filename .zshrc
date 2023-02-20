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
zstyle ':zim:pacman' frontend 'paru'

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
export BASE16_SHELL="$HOME/src/base16-builder-python/output/shell"
export FZF="/usr/share/fzf"

# Check for Display
if [ -n "$DISPLAY" ]; then
  # Use a different color scheme for each workspace
  ws=$(wmctrl -d | grep '*' | cut -d ' ' -f14)
  if [ "$ws" = 1 ]; then
    export BASE16_THEME="decaf"
  elif [ "$ws" = 2 ]; then
    export BASE16_THEME="oceanicnext-purple"
  elif [ "$ws" = 3 ]; then
    export BASE16_THEME="ocean"
  elif [ "$ws" = 4 ]; then
    export BASE16_THEME="materia"
  else
    export BASE16_THEME="decaf"
  fi
  [[ -n $BASE16_THEME ]] && source "$BASE16_SHELL/scripts/base16-$BASE16_THEME.sh"
  # Start tmux service
  if ! systemctl --user is-active --quiet tmux.service; then
    systemctl --user start tmux.service;
  fi
  # Attach shell to workspace tmux session and force unicode
  [[ -z $(tmux ls | grep -e $ws": .*attached") ]] && tmux -u new -As "$ws"
fi

# Preferred editor for local and remote sessions
export EDITOR='nvim'
if [[ -n "$SSH_CONNECTION" ]]; then
    export DISPLAY=:0
fi

# System environment
export LD_LIBRARY_PATH="/opt/OpenBLAS/lib:/opt/cuda/lib64:\
/opt/cuda/extras/CUPTI/lib64:$HOME/.local/lib:$LD_LIBRARY_PATH"

# Keys
export GNUPGHOME="$HOME/.gnupg"
export GPGKEY=716809DD
export PASSWORD_STORE_DIR="$HOME/.password-store"

#-1 User environment
# Path needs to include composer and go bin paths
export PATH="$HOME/.local/bin:$PATH:$HOME/.config/composer/vendor/bin:\
$HOME/.local/share/go/bin:$HOME/.local/share/gem/ruby/3.0.0/bin"
export LIBVA_DRIVER_NAME=iHD
# Go path
export GOPATH="$HOME/.local/share/go"
# Java path
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
# PyEnv
pyenv() {
  unset -f pyenv
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PATH:$PYENV_ROOT/bin"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  pyenv $@
}
# NVM
nvm() {
  unset -f nvm
  [ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
  source /usr/share/nvm/nvm.sh --no-use
  source /usr/share/nvm/bash_completion
  source /usr/share/nvm/install-nvm-exec
  nvm $@
}

# pager vars
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "
export BAT_THEME="base16"
# FZF vars
source "$FZF/completion.zsh"
source "$FZF/key-bindings.zsh"
export FZF_COMPLETION_TRIGGER="**"
export FZF_DEFAULT_OPTS="--height 50% \
  --preview='bat --style=numbers --color=always --line-range :500 {}' \
  --preview-window=right:50% --cycle --multi \
  --bind=?:toggle-preview --bind=tab:down --bind=btab:up --bind=space:toggle \
  --bind=ctrl-d:half-page-down --bind=ctrl-u:half-page-up \
  --color fg:7,bg:-1,hl:6,fg+:7,bg+:18,hl+:3,border:19 \
  --color gutter:-1,info:8,prompt:5,spinner:15,pointer:16,marker:3"
export FZF_DEFAULT_COMMAND="fd -i -H -I -F -L -E \".git\" -E \"node_modules\"\
  -E \"__pycache__\" -E \".mypy_cache\""
_fzf_compgen_path() {
  fd -i -H -I -F -L -E ".git" -E "node_modules" -E ".mypy_cache" -E "__pycache__" . "$1"
}
# LF vars
#LF_ICONS=$(sed ~/.config/lf/diricons \
#            -e '/^[ \t]*#/d'       \
#            -e '/^[ \t]*$/d'       \
#            -e 's/[ \t]\+/=/g'     \
#            -e 's/$/ /')
#LF_ICONS=${LF_ICONS//$'\n'/:}
#export LF_ICONS

# Aliases
alias nv="nvim"
alias sc="sudo systemctl"
alias scu="systemctl --user"
alias jc="sudo journalctl"
alias jcu="journalctl --user-unit"
alias dk="docker"
alias dkc="docker-compose"
alias op="xdg-open"
alias gssh="gcloud compute ssh"
alias tre="fd | as-tree"
alias kc="kubectl"
