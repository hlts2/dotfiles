# .bashrc


if [[ $OSTYPE == "darwin"* ]]; then
    alias ls='ls -FG'
    alias ll='ls -alFG'
fi

export PS1=[\u@\h \W]\$
