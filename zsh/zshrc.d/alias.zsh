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

# _mkcd() {
#     mkdir $* && echo $_
# }
# alias mkcd="_mkcd"
alias mkdir='mkdir -p'

if type grep --color > /dev/null 2>&1; then
    alias grep='grep --color'
    alias grepr='grep --color -r'
fi

if type git > /dev/null 2>&1; then
    alias gadda='git add -A'
    alias gcomm='git commit --signoff -m'
else
    echo 'git command not found' 1>&2
fi

if type nvim > /dev/null 2>&1; then
    alias vim=nvim
fi

if type xsel > /dev/null 2>&1; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
fi

if type kubectl > /dev/null 2>&1; then
    alias k='kubectl'
fi

if type tmux > /dev/null 2>&1; then
    alias tmuxs='tmux new-session \; \
        split-window -h -p 50 \; \
        split-window -v -p 50 \; \
        selectp -t 0;'
fi
