#!bin/sh

alias ..='cd ../'
alias ....='cd ../../'

alias ls='ls -G -F'
alias t='tree'

alias vim='nvim'

alias edvim='vim $HOME/.vimrc'
alias ednvim='vim $HOME/.config/nvim/init.vim'
alias edzh='vim $HOME/.zshrc'
    
alias :q='exit'

alias tmuxs='tmux new-session \; \
  split-window -h -p 50 \; \
  split-window -v -p 50 \; \
  selectp -t 0;'

if type git >/dev/null 2>&1; then
    alias gdiff='git diff'
    alias gstat='git status'
    alias gadda='git add -A'
    alias gcomm='git commit -m'
    alias gbr='git branch'
    alias gpsh='git push'
fi
