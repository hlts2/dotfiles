.PHONY: link

link:
	mkdir -p ${HOME}/.config/nvim/colors
	mkdir -p ${HOME}/.config/nvim/syntax
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))bashrc $(HOME)/.bashrc
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))bash_profile $(HOME)/.bash_profile
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))init.vim $(HOME)/.config/nvim/init.vim
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))alacritty.yml $(HOME)/.config/alacritty/alacritty.yml
