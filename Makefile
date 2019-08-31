.PHONE: link

DOTFILE_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

link:
	mkdir -p ${HOME}/.config/nvim/colors
	ln -svf $(DOTFILE_DIR)/vimrc $(HOME)/.config/nvim/init.vim
	ln -svf $(DOTFILE_DIR)/$(HOME)/vimrc $(HOME)/.vimrc
	ln -svf $(DOTFILE_DIR)/.vim $(HOME)/.vim

vim: link
	echo "aaa"

nvim: link
	echo "bbb"

