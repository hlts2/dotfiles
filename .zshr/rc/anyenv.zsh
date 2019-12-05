#!bin/sh

# rbenv
export RBENV_ROOT="$HOME/.rbenv"
export PATH=$RBENV_ROOT/bin:$PATH

if [ -d "${HOME}/.rbenv" ]; then
  eval "$(rbenv init - --no-hash)"
else  
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
fi

# nodenv
export NODENV_ROOT="$HOME/.nodenv"
export PATH="$NODENV_ROOT/bin:$PATH"

if [ -d "${HOME}/.nodenv" ]; then
  eval "$(nodenv init - --no-hash)"
else  
    git clone https://github.com/nodenv/nodenv.git ~/.nodenv
fi

# rbenv
export RBENV_ROOT="$HOME/.rbenv"
export PATH=$RBENV_ROOT/bin:$PATH

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if [ -d "$HOME/.pyenv" ]; then
    eval "$(pyenv init -)"
else
    git clone git://github.com/yyuu/pyenv.git ~/.pyenv
fi


# goenv
export GOENV_ROOT=$HOME/.goenv
export PATH=$GOENV_ROOT/bin:$PATH

if [ -d "$HOME/.goenv" ]; then
    eval "$(goenv init -)"
else
    git clone https://github.com/syndbg/goenv.git ~/.goenv
fi
