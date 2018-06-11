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
    zplug "zsh-users/zsh-history-substring-search"      #word C-p
    zplug "b4b4r07/enhancd", use:init.sh                #Movement
    zplug "supercrabtree/k"

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

    autoload -Uz colors
    colors
    PROMPT="%{$fg[cyan]%}%/#%{$reset_color%} %"

    alias ..='cd ../'
    alias ....='cd ../../'

    alias cddoc='cd $HOME/Documents'
    alias cddld='cd $HOME/Downloads'
    alias cdpg='cd $HOME/Documents/Programming'
    alias cdgome='cd $HOME/Documents/Programming/Go/src/github.com/hlts2'
    alias cddot='cd $HOME/dotfiles'

    alias cdgo='cd $HOME/Documents/Programming/Go'
    alias cdswift='cd $HOME/Documents/Programming/Swift'
    alias cdc='cd $HOME/Documents/Programming/C'
    alias cdjava='cd $HOME/Documents/Programming/Java'
    alias cdpy='cd $HOME/Documents/Programming/Python'
    alias cdphp='cd $HOME/Documents/Programming/php'
    alias cdscm='cd $HOME/Documents/Programming/scheme'

    alias cddro='cd $HOME/Documents/Programming/Android'
    alias cdios='cd $HOME/Documents/Programming/iOS'

    alias cdcent='cd $HOME/vagrant/CentOS7'
    alias cdcore='cd $HOME/vagrant/CoreOS'

    alias ls='ls -G -F'

    alias vim='nvim'
    alias vi='nvim'

    alias tmuxs='tmux new-session \; \
  split-window -h -p 50 \; \
  split-window -v -p 50 \; \
  selectp -t 0;'

    if [ -d $HOME/.config/nvim ]; then
        alias ednvim='vim $HOME/.config/nvim/init.vim'
    fi

    alias edvim='vim $HOME/.vimrc'

    alias edzh='vim $HOME/.zshrc'

    if type git >/dev/null 2>&1; then
        alias gdiff='git diff'
        alias gstat='git status'
        alias gadda='git add -A'
        alias gcomm='git commit -m'
        alias gbr='git branch'
        alias gpsh='git push'
    fi

    alias :q='exit'

    export ZSH_LOADED=1
fi
