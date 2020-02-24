# ----------------------------------------
# Author: Hiroto Funakoshi
# Source: https://github.com/hlts2/dotfiles
# ----------------------------------------

export OS=$(uname -s)
export USER=$(whoami)
export SHELL=$(which zsh)
export TZ=Asia/Tokyo

export LANG=en_US.UTF-8
export MANLANG=ja_JP.UTF-8
export LC_TIME=en_US.UTF-8

export TERM=xterm-256color

export XDG_CONFIG_HOME=$HOME/.config
export ZPLUG_HOME=$HOME/.zplug
export NVIM_HOME=$XDG_CONFIG_HOME/nvim
export VIM_PLUG_HOME=$NVIM_HOME/plugged/vim-plug

if type go > /dev/null 2>&1; then
    if [ $USER = "root" ]; then
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
    # export CGO_CFLAGS="-g -Ofast -march=native"
    # export CGO_CPPFLAGS="-g -Ofast -march=native"
    # export CGO_CXXFLAGS="-g -Ofast -march=native"
    # export CGO_FFLAGS="-g -Ofast -march=native"
    # export CGO_LDFLAGS="-g -Ofast -march=native"
    export PATH=$GOBIN:$GOROOT/bin:$PATH

    if type git > /dev/null 2>&1; then
        _go-gets(){
            go get -u github.com/klauspost/asmfmt/cmd/asmfmt \
            github.com/go-delve/delve/cmd/dlv \
            ithub.com/kisielk/errcheck \
            ithub.com/davidrjenni/reftools/cmd/fillstruct \
            ithub.com/mdempsky/gocode \
            ithub.com/stamblerre/gocode \
            ithub.com/rogpeppe/godef \
            ithub.com/zmb3/gogetdoc \
            olang.org/x/tools/cmd/goimports \
            olang.org/x/lint/golint \
            olang.org/x/tools/gopls@latest \
            ithub.com/fatih/gomodifytags \
            olang.org/x/tools/cmd/gorename \
            ithub.com/jstemmer/gotags \
            olang.org/x/tools/cmd/guru \
            ithub.com/josharian/impl \
            onnef.co/go/tools/cmd/keyify \
            ithub.com/fatih/motion \
            ithub.com/koron/iferr \
            ithub.com/ChimeraCoder/gojson/gojson \
            ithub.com/cweill/gotests/gotests \
            ithub.com/gnewton/chidley \
            ithub.com/x-motemen/ghq \
            ithub.com/mattn/efm-langserver \
            ourcegraph.com/sqs/goreturns \
            ithub.com/kpango/glg \
            ithub.com/wantedly/subee/cmd/subee \
            ithub.com/hlts2/holijp \
            o.uber.org/zap \
            o.uber.org/multierr \
            opkg.in/yaml.v2
        }
        alias go-gets='_go-gets'
    fi
fi

# Prompt
autoload -Uz colors
colors
PROMPT="%{${fg[cyan]}%}%n@%m:%/#%{$reset_color%} %"


# Completion
autoload -U compinit
compinit

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
zstyle ':completion:*' group-name ''

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)[%b]'
zstyle ':vcs_info:*' actionformats '(%s)[%b|%a]'
precmd () { vcs_info }
setopt prompt_subst
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history
setopt inc_append_history
setopt hist_save_no_dups
setopt hist_reduce_blanks
setopt EXTENDED_HISTORY

setopt auto_cd
setopt auto_pushd

setopt extended_glob
setopt BRACE_CCL

setopt AUTO_PARAM_KEYS
setopt COMPLETE_ALIASES
setopt COMPLETE_IN_WORD

# aliases
case "${OSTYPE}" in
darwin*)
    alias ls='ls -G'
    alias ll='ls -lG'
    alias la='ls -laG'
    ;;
linux*)
    alias ls='ls --color'
    alias ll='ls -l --color'
    alias la='ls -la --color'
    ;;
esac

if type grep --color > /dev/null 2>&1; then
    alias grep='grep --color'
    alias grepr='grep --color -r'
fi

alias rm='rm -i'
alias mv='mv -i'

alias ..='cd ../'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cddot='cd ~/dotfiles'

alias zrc='. ~/.zshrc'

alias edzrc='vim ~/.zshrc'
alias edvim='vim ~/.vimrc'
alias ednvim='vim $NVIM_HOME/init.vim'
alias edtmux='vim ~/.tmux.conf'

_mkcd() {
    mkdir $* && cd $_
}

alias mkcd="_mkcd"
alias mkdir='mkdir -p'

if type kubectl > /dev/null 2>&1; then
    alias k="kubectl"
    source <("$kubectl" completion zsh)
fi

if [ "$USER" = 'root' ]; then
    export GOPATH=/go
else
    export GOPATH=$HOME/go
fi

if type nvim > /dev/null 2>&1; then
    export VIM=$(which nvim)
    export VIMRUNTIME=/usr/share/nvim/runtime
    export NVIM_HOME=$XDG_CONFIG_HOME/nvim
    export VIM_PLUG_HOME=$NVIM_HOME/plugged/vim-plug
elif type vim > /dev/null 2>&1; then
    export VIM=$(which vim)
    export VIMRUNTIME=/usr/share/vim/vim*
    export VIM_HOME="$HOME/.vim"
    export VIM_PLUG_HOME=$VIM_HOME/plugged/vim-plug
else
    export VIM=$(which vi)
fi
alias vim=$VIM

if type tmux > /dev/null 2>&1; then
    alias tmuxs='tmux new-session \; \
        split-window -h -p 50 \; \
        split-window -v -p 50 \; \
        selectp -t 0;'
fi

if type docker > /dev/null 2>&1; then
    if [ -f $HOME/.aliases/docker ]; then
        source $HOME/.aliases/docker 
    fi
fi

# zplug
export ZPLUG_HOME=$HOME/.zplug

if type git > /dev/null 2>&1; then
    alias gadda='git add -A'
    alias gcomm='git commit --signoff -m'
    alias gdiff='git diff --color-words'
    alias gfix='git add -A; git commit -m "fix"; git push'


    if [ ! -f $ZPLUG_HOME/init.zsh ]; then
        rm -rf $ZPLUG_HOME
        git clone https://github.com/zplug/zplug $ZPLUG_HOME
    fi

    source $ZPLUG_HOME/init.zsh

    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-completions", as:plugin, use:"src"
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    zplug "zsh-users/zsh-history-substring-search"

    if ! zplug check --verbose; then
        zplug install
    fi

    zplug load

    if [ ! -d "$HOME/.fzf" ]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
    fi

    source ~/.fzf.zsh
fi
