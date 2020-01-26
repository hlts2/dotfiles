# .bashrc

export PS1='\[\e[36;40m\]\u@\h:$(pwd)\$ \[\e[0m\]'

# alias

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

alias gadda='git add -A'
alias gcomm='git commit -m'
alias gfix='git add -A; git commit -m "fix"; git push'

alias rm='rm -i'
alias mv='mv -i'

alias ..='cd ../'
alias ...='cd ../..'
alias ....='cd ../../..'

alias edbrc='vim ~/.bashrc'
alias brc='. ~/.bashrc'

alias edvim='vim ~/.vimrc'
alias ednvim='vim ~/.vimrc'
