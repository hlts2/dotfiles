# .bashrc

export PS1='\[\e[36;40m\]$(pwd)\$ \[\e[0m\]'

# alias

if ls --color > /dev/null 2>&1; then
    alias ls='ls --color -F'
    alias lsa='ls --color -F -a'
    alias lsl='ls --color -F -l'
    alias lsal='ls --color -F -a -l'
else
    alias lsa='ls -a'
    alias lsl='ls -l'
    alias lsal='ls -al'
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

alias tinyvim='vim -u ~/.tinyvimrc'
alias tvim=tinyvim

