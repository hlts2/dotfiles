# .bashrc

export PS1='\[\e[36;40m\]\u@\h:$(pwd)\$ \[\e[0m\]'

export VIM_HOME='$HOME/.vim'

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
alias cddot='cd ~/dotfiles'

alias edbrc='vim ~/.bashrc'
alias brc='. ~/.bashrc'

alias edvim='vim ~/.vimrc'
alias edtmux='vim ~/.tmux.conf'

if type docker > /dev/null 2>&1; then
    if [ -f $HOME/.aliases/docker ]; then
        source $HOME/.aliases/docker 
    fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. "$HOME/.cargo/env"
