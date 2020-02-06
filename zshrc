# ----------------------------------------
# Author: Hiroto Funakoshi
# Source: https://github.com/hlts2/dotfiles
# ----------------------------------------

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


# Prompt
autoload -Uz colors
colors
PROMPT="%{$fg[cyan]%}%/#%{$reset_color%} %"


alias ls='ls --color'
alias t='tree'


# zplug
export ZPLUG_HOME=$HOME/.zplug

if type git > /dev/null 2>&1; then
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
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
