#!bin/sh

if [ -z $ENV_LOADED ]; then

    # Zplug Env
    export ZPLUG_HOME=$HOME/.zplug

    # Nvim Env
    export XDG_CONFIG_HOME=$HOME/.config
    export NVIM_HOME=$XDG_CONFIG_HOME/nvim

    # Programming Env
    export PROGRAMMING_HOME=$HOME/Documents/Programming

    if [ -d $HOME/.anyenv ]; then
        export PATH="$HOME/.anyenv/bin:$PATH"
        eval "$(anyenv init - --no-rehash -zsh)"
    fi

    #GO
    if type go > /dev/null 2>&1; then
        export GOROOT="$(go env GOROOT)"
        export GOPATH=$PROGRAMMING_HOME/Go
        export PATH=$GOPATH/bin:$PATH
    fi

    #Node
    export PATH=$HOME/.nodebrew/current/bin:$PATH

    export ENV_LOADED=1
fi

if [ -f $HOME/.zplug/init.zsh ]; then
    source $ZPLUG_HOME/init.zsh

    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    zplug "zsh-users/zsh-history-substring-search" 		#word C-p
    zplug "b4b4r07/enhancd", use:init.sh				#Movement

    if ! zplug check --verbose; then
        zplug install
    fi

    zplug load
else
    rm -rf $ZPLUG_HOME
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
    source $ZPLUG_HOME
fi

if ! [ -z $TMUX ] || [ -z $ZSH_LOADED ]; then

    # Color Setting
    autoload -Uz colors
    colors
    PROMPT="%{$fg[cyan]%}%/#%{$reset_color%} %"

    # Alias Setting
    alias cdgo='cd $HOME/Documents/Programming/Go'
    alias cdgome='cd $HOME/Documents/Programming/Go/src/github.com/hlts2'
    alias cdswift='cd $HOME/Documents/Programming/Swift'
    alias cdc='cd $HOME/Documents/Programming/C'
    alias cdjava='cd $HOME/Documents/Programming/Java'
    alias cdandroid='cd $HOME/Documents/Programming/Android'
    alias cdpy='cd $HOME/Documents/Programming/Python'
    alias cdphp='cd $HOME/Documents/Programming/php'
    alias cdios='cd $HOME/Documents/Programming/iOS'
    alias cdcent='cd $HOME/vagrant/CentOS7'
    alias cdcore='cd $HOME/vagrant/CoreOS'

    alias ls='ls -G -F'

    alias rmds='sudo find / -name .DS_Store | xargs rm'

    # nvim & vim
    alias vim='nvim'
    alias vi='nvim'
    alias ednvim='vim $HOME/.config/nvim/init.vim'
    alias edvim='vim $HOME/.vimrc'

    # zsh
    alias edzsh='vim $HOME/.zshrc'

    alias :q='exit'

    export ZSH_LOADED=1
fi
