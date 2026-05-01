export GPG_TTY=$(tty)
export OS=${OSTYPE}
export TERM=xterm-256color
export TZ=Asia/Tokyo
export LANG=en_US.UTF-8
export MANLANG=ja_JP.UTF-8
export LC_TIME=en_US.UTF-8
export XDG_CONFIG_HOME=$HOME/.config
export ZPLUG_HOME=$HOME/.zplug
export EDITOR=nvim
export GIT_EDITOR=$EDITOR
export VISUAL=$EDITOR
export PATH="$HOME/.local/bin:$PATH"
export ZIM_HOME=$HOME/.zim
export ZIM_CONFIG_FILE=$HOME/.zimrc

# Bun
export PATH="$HOME/.bun/bin:$PATH"

# Go
export GOROOT=${GOROOT:-/usr/local/go}
if [[ $USER == 'root' ]]; then
    export GOPATH=${GOPATH:-/go}
else
    export GOPATH=${GOPATH:-$HOME/go}
fi
export CGO_ENABLED=1
export GO111MODULE=on
export GOBIN=$GOPATH/bin
export GO15VENDOREXPERIMENT=1
export GOPRIVATE="github.com/civo/*,github.com/Arts-Japan/*,git.civo.com/*,github.com/BANKEY-tech/*"
export NVIM_GO_LOG_FILE=$XDG_DATA_HOME/go
export GOFLAGS='-tags=e2e -ldflags="-w -s"'
export CGO_CFLAGS="-g -Ofast -march=native"
export CGO_CPPFLAGS="-g -Ofast -march=native"
export CGO_CXXFLAGS="-g -Ofast -march=native"
export CGO_FFLAGS="-g -Ofast -march=native"
export CGO_LDFLAGS="-g -Ofast -march=native"
export PATH=$GOBIN:/usr/local/go/bin:$PATH

# Wasm
export WASMTIME_HOME="$HOME/.wasmtime"
export PATH="$WASMTIME_HOME/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# fzf
export FZF_DEFAULT_OPTS="--height 30% --layout=reverse --border"

# SSH Agent: only check on login shells
export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
if [[ -o login ]] && ! pgrep -u "$USER" ssh-agent > /dev/null 2>&1; then
    rm -f "$SSH_AUTH_SOCK"
    eval "$(ssh-agent -a "$SSH_AUTH_SOCK")" > /dev/null
fi
