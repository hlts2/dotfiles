#!bin/sh

export ZPLUG_HOME=$HOME/.zplug
export NVIM_HOME=$XDG_CONFIG_HOME/nvim
export PROGRAMMING_HOME=$HOME/Documents/Programming
export XDG_CONFIG_HOME=$HOME/.config
export NVIM_HOME=$XDG_CONFIG_HOME/nvim
export TERM=xterm-256color

# Go
if [ "$USER" = 'root' ]; then
    export GOPATH=/go
else
    export GOPATH=$HOME/go
fi

export CGO_ENABLED=1
export GO111MODULE=on
export GOBIN=$GOPATH/bin
export GO15VENDOREXPERIMENT=1

if type go >/dev/null 2>&1; then
    export GOROOT="$(go env GOROOT)"
    export GOOS="$(go env GOOS)"
    export GOARCH="$(go env GOARCH)"
    # export GOBIN=$GOPATH/"$(go version | awk '{print substr($3, 3)}')"/bin
    export GOBIN=$GOPATH/1.13.0/bin
fi

export PATH=$GOBIN:$PATH
