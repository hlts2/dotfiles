if [ ! -f $ZPLUG_HOME/init.zsh ]; then
    rm -rf $ZPLUG_HOME && git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions", as:plugin, use:"src"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search"
zplug "romkatv/powerlevel10k", as:theme, depth:1

if ! zplug check --verbose; then
    zplug install
fi

zplug load
