.PHONE: link

DOTFILE_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

link:
	mkdir -p ${HOME}/.config/nvim/colors
	ln -svf $(DOTFILE_DIR)/vimrc $(HOME)/.config/nvim/init.vim
	ln -svf $(DOTFILE_DIR)/vimrc $(HOME)/.vimrc
	ln -svf $(DOTFILE_DIR)/.vim/ $(HOME)
	ln -svf $(DOTFILE_DIR)/zshrc $(HOME)/.zshrc
	ln -svf $(DOTFILE_DIR)/.zsh/ $(HOME)
