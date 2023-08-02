if [ ! -d $HOME/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
fi

if type fzf > /dev/null 2>&1; then
    source $HOME/.fzf/shell/completion.zsh
    source $HOME/.fzf/shell/key-bindings.zsh
fi
