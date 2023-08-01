export GPG_TTY=$(tty)
export OS=$(uname -s)
export USER=$(whoami)
export SHELL=$(which zsh)
export TERM=xterm-256color
export TZ=Asia/Tokyo
export LANG=en_US.UTF-8
export MANLANG=ja_JP.UTF-8
export LC_TIME=en_US.UTF-8
export XDG_CONFIG_HOME=$HOME/.config
export ZPLUG_HOME=$HOME/.zplug
export EDITOR=$(which nvim)
export GIT_EDITOR=$EDITOR
export VISUAL=$EDITOR
export PATH="$HOME/.local/bin:$PATH"
export ZPLUG_HOME=$HOME/.zplug

export AQUA_VERSION=2.1.1
export AQUA_ROOT_DIR=$HOME/.config/aquaproj-aqua
export AQUA_GLOBAL_CONFIG=$AQUA_ROOT_DIR/aqua.yaml
export PATH=$AQUA_ROOT_DIR/bin:$PATH

# export ASDF_HOME=$HOME/.asdf
