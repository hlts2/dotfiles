# .bashrc

export PS1='\[\e[36;40m\]$(pwd)\$ \[\e[0m\]'

if [[ $OSTYPE == "darwin"* ]]; then
    alias ls='ls -FG'
    alias ll='ls -alFG'
fi

alias gfix='git add -A; git commit -m "fix"; git push'

# bashrc
alias edbash='vim ~/.bashr'
alias bcommit='. ~/.bashrc'

