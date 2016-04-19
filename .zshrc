# Path to your oh-my-zsh installation.
export ZSH=/home/cilsat/.oh-my-zsh

ZSH_THEME=agnoster

DEFAULT_USER="cilsat"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

# Use a different color scheme for each workspace
ws=$(wmctrl -d | grep '*' | cut -d " " -f14)
if [ "$ws" = 1 ];then
    BASE16_SHELL="$HOME/.config/base16-shell/base16-paraiso.dark.sh"
elif [ "$ws" = 2 ];then
    BASE16_SHELL="$HOME/.config/base16-shell/base16-darktooth.dark.sh"
elif [ "$ws" = 3 ];then
    BASE16_SHELL="$HOME/.config/base16-shell/base16-oceanicnext.dark.sh"
elif [ "$ws" = 4 ];then
    BASE16_SHELL="$HOME/.config/base16-shell/base16-ocean.dark.sh"
elif [ "$ws" = 5 ];then
    BASE16_SHELL="$HOME/.config/base16-shell/base16-marrakesh.light.sh"
fi
#BASE16_SHELL="$HOME/.config/base16-shell/base16-marrakesh.light.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Resume workspace session in workspace terminals. If session already attached 
# then create a new one.
if [ -z $TMUX ];then
    attached=$(tmux ls | grep "$ws: " | cut -d " " -f14)
    if [ "$attached" != "(attached)" ];then
        tmux -2 new -As "$ws"
    fi
fi

export LD_LIBRARY_PATH=/opt/OpenBLAS/lib:$LD_LIBRARY_PATH

# Proxy ITB
#ttp_proxy=http://cache.itb.ac.id:8080/
#ttps_proxy=http://cache.itb.ac.id:8080/
#tp_proxy=http://cache.itb.ac.id:8080/
#o_proxy="localhost, 127.0.0.1, *.itb.ac.id"
#TTP_PROXY=http://cache.itb.ac.id:8080/
#TTPS_PROXY=http://cache.itb.ac.id:8080/
#TP_PROXY=http://cache.itb.ac.id:8080/
#O_PROXY="localhost, 127.0.0.1, *.itb.ac.id"

# Java environment
export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64
export SCALA_HOME=/usr/bin/scala
export SPARK_HOME=/home/cilsat/lib/spark-1.5.1-bin-hadoop2.6

# Python virtualenvs
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev
source /usr/local/bin/virtualenvwrapper_lazy.sh

# Ruby environment
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(command-not-found git-fast svn-fast-info python virtualenvwrapper nyan ssh-agent zsh-syntax-highlighting)

# User configuration
# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets root line)

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin: \
    /usr/games:/usr/local/games:/home/cilsat/bin:/home/cilsat/.conda/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
    export TERM=tmux-256color
else
    export EDITOR='vim'
    export TERM=xterm-256color
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# keys
export SSH_KEY_PATH="~/.ssh/rsa_id"
export GPGKEY=716809DD

# Users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias nv="nvim"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
