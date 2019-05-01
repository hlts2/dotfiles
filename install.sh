#!bin/bash

rm $HOME/.zshrc
ln -sf $HOME/dotfiles/.zshrc $HOME/.zshrc

rm $HOME/.vimrc
ln vimrc $HOME/.vimrc

mkdir -p $HOME/.config/nvim/plugged
rm $HOME/.config/nvim/init.vim
ln -sf $HOME/dotfiles/init.vim $HOME/.config/nvim/init.vim

rm $HOME/.tmux.conf
ln -sf $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf

cp $HOME/.gitignore $HOME/.gitignore_back
rm $HOME/.gitignore
ln -sf $HOME/dotfiles/.gitignore $HOME/.gitignore


go get -u golang.org/x/tools/cmd/gopls
