# ----------------------------------------
# Author: Hiroto Funakoshi
# Source: https://github.com/hlts2/dotfiles
# ----------------------------------------


# zplug
# zplug
export ZPLUG_HOME=$HOME/.zplug

if type git > /dev/null 2>&1; then
    if [ ! -f $ZPLUG_HOME/init.zsh ]; then
        rm -rf $ZPLUG_HOME
        git clone https://github.com/zplug/zplug $ZPLUG_HOME
    fi

    source $ZPLUG_HOME/init.zsh

    zplug "zsh-users/zsh-syntax-highlighting", defer:2

    if ! zplug check --verbose; then
        zplug install
    fi

    zplug load
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
