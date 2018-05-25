#!bin/bash

rm $HOME/.zshrc
cp ./zshrc $HOME/.zshrc

rm $HOME/.vimrc
cp ./vimrc $HOME/.vimrc

mkdir -p $HOME/.config/nvim/plugged
cp ./init.vim $HOME/.config/nvim/init.vim

rm $HOME/.tmux.conf
cp ./tmux.conf $HOME/.tmux.conf

cp $HOME/.gitignore $HOME/.gitignore_back
cp ./gitignore $HOME/.gitignore
