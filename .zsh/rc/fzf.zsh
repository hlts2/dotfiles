#!bin/sh

if [ -d "$HOME/.fzf" ]; then
    source ~/.fzf.zsh
else
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    source ~/.fzf.zsh
fi
