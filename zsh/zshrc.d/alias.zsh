alias rm='rm -i'
alias mv='mv -i'

alias ..='cd ../'
alias ...='cd ../..'
alias ....='cd ../../..'

case $OSTYPE in
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

CIVO_REGION_WORK_DIR="${HOME}/go/src/git.civo.com/hiroto"
alias stgcd="cd ${CIVO_REGION_WORK_DIR}/staging"
alias prdcd="cd ${CIVO_REGION_WORK_DIR}/prod"

alias mkdir='mkdir -p'

if (( $+commands[grep] )); then
    alias grep='grep --color'
    alias grepr='grep --color -r'
fi

if (( $+commands[git] )); then
    alias gadda='git add -A'
    alias gcomm='git commit --signoff -m'
fi

if (( $+commands[nvim] )); then
    alias vim=nvim
fi

if (( $+commands[wl-copy] )); then
    alias pbcopy='wl-copy'
    alias pbpaste='wl-paste'
fi

if (( $+commands[kubectl] )); then
    alias k='kubectl'
fi
