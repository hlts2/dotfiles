#!bin/bash

rm $HOME/.zshrc
ln zshrc $HOME/.zshrc

rm $HOME/.vimrc
ln vimrc $HOME/.vimrc

mkdir -p $HOME/.config/nvim/plugged
ln init.vim $HOME/.config/nvim/init.vim

rm $HOME/.tmux.conf
ln tmux.conf $HOME/.tmux.conf

cp $HOME/.gitignore $HOME/.gitignore_back
ln gitignore $HOME/.gitignore
