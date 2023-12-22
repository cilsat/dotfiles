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
# Set identities to automatically load
zstyle ':zim:ssh' ids 'id_rsa1'

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi
# Initalize
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
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

# Attach shell to workspace tmux session and force unicode
[[ -z $(tmux ls | grep -e $ws": .*attached") ]] && tmux -u new -As "$ws"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
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
  source /opt/homebrew/opt/nvm/nvm.sh --no-use
  source /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm
  nvm $@
}

# PHPBrew
[[ -e $HOME/.phpbrew/bashrc ]] && source $HOME/.phpbrew/bashrc

# Aliases
alias nv="nvim"
alias gssh="gcloud compute ssh"
alias tre="fd | as-tree"
alias kc="kubectl"
