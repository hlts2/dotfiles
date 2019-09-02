#!bin/sh

export ZPLUG_HOME=$HOME/.zplug
export ZPLUG_CONFIG_DIR=$

if [ -f $HOME/.zplug/init.zsh ]; then
    source $ZPLUG_HOME/init.zsh

    if ! zplug check --verbose; then
        zplug install
    fi

    zplug load
else
    rm -rf $ZPLUG_HOME
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
    source $ZPLUG_HOME
fi
