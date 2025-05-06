export DEFAULT_USER=cilsat
export HOME=/Users/$DEFAULT_USER

export LANG=en_US.UTF-8

# Set ZIM home
export ZIM_HOME=${HOME}/.zim

# Preferred editor for local and remote sessions
export EDITOR='nvim'
if [[ -n "$SSH_CONNECTION" ]]; then
    export DISPLAY=:0
fi

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
export JAVA_HOME="/opt/homebrew/Cellar/openjdk/23.0.1/libexec/openjdk.jdk/Contents/Home"

# pager vars
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "
export BAT_THEME="base16"
#. "$HOME/.cargo/env"

# PHP 8.1
export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
