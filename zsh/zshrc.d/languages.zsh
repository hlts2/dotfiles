# Go 
if [ $USER = 'root' ]; then
    export GOPATH=/go
else
    export GOPATH=$HOME/go
fi
export GOROOT="$(go env GOROOT)"
export GOOS="$(go env GOOS)"
export GOARCH="$(go env GOARCH)"
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

# Rust
if [ ! -d "$HOME/.cargo" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
source "$HOME/.cargo/env"


# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if [ ! -d "$HOME/.pyenv" ]; then
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi
eval "$(pyenv init -)"

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

if [ ! -d $HOME/.volta ]; then
    curl https://get.volta.sh | bash
fi
