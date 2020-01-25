# .bashrc

export PS1='\[\e[36;40m\]$(pwd)\$ \[\e[0m\]'

# alias

if [[ $OSTYPE == "darwin"* ]]; then
    alias ls='ls -FG'
    alias ll='ls -alFG'
fi

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

