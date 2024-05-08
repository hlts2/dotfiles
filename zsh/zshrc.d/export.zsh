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

export LANG_GO_VERSION=1.21.0
export LANG_PYTHON_VERSION=3.11.1
export LANG_NODE_VERSION=18.16.0

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Go
if [ $USER = 'root' ]; then
    export GOPATH=/go
else
    export GOPATH=$HOME/go
fi
export PATH=/usr/local/go/bin:$PATH
if type go > /dev/null 2>&1; then
    export GOROOT="$(go env GOROOT)"
    export GOOS="$(go env GOOS)"
    export GOARCH="$(go env GOARCH)"
fi
export CGO_ENABLED=1
export GO111MODULE=on
export GOBIN=$GOPATH/bin
export GO15VENDOREXPERIMENT=1
export GOPRIVATE="*.yahoo.co.jp"
export NVIM_GO_LOG_FILE=$XDG_DATA_HOME/go
# export GOFLAGS="-ldflags=\"-w -s\""
export GOFLAGS="-tags=e2e"
export CGO_CFLAGS="-g -Ofast -march=native"
export CGO_CPPFLAGS="-g -Ofast -march=native"
export CGO_CXXFLAGS="-g -Ofast -march=native"
export CGO_FFLAGS="-g -Ofast -march=native"
export CGO_LDFLAGS="-g -Ofast -march=native"
export PATH=$GOBIN:$GOROOT/bin:$PATH

# Aqua
export AQUA_VERSION=2.1.1
export AQUA_ROOT_DIR=$HOME/.config/aquaproj-aqua
export AQUA_GLOBAL_CONFIG=$AQUA_ROOT_DIR/aqua.yaml
export PATH=$AQUA_ROOT_DIR/bin:$PATH

# Wasm
export WASMTIME_HOME="$HOME/.wasmtime"
export PATH="$WASMTIME_HOME/bin:$PATH"
