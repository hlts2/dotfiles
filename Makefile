.PHONY: link

link:
	mkdir -p ${HOME}/.config/nvim/colors
	mkdir -p ${HOME}/.config/nvim/syntax
	mkdir -p ${HOME}/.config/alacritty
	mkdir -p ${HOME}/.aliases
	touch netrc
	
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))gitconfig $(HOME)/.gitconfig
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))gitattributes $(HOME)/.gitattributes
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))gitcommit-template $(HOME)/.gitcommit-template
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))gitignore $(HOME)/.gitignore
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))tmux.conf $(HOME)/.tmux.conf
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))netrc $(HOME)/.netrc
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))bashrc $(HOME)/.bashrc
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))bash_profile $(HOME)/.bash_profile
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))zshrc $(HOME)/.zshrc
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))ideavimrc $(HOME)/.ideavimrc
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))vimrc $(HOME)/.vimrc
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))init.vim $(HOME)/.config/nvim/init.vim
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))coc-settings.json $(HOME)/.config/nvim/coc-settings.json
	ln -sfv $(dir $(abspath $(lastword $(MAKEFILE_LIST))))alacritty.yml $(HOME)/.config/alacritty/alacritty.yml

clean:
	sudo rm -rf $(HOME)/.gitconfig \
        $(HOME)/.gitattributes \
        $(HOME)/.gitcommit-template \
        $(HOME)/.gitignore \
        $(HOME)/.tmux.conf \
        $(HOME)/.netrc \
        $(HOME)/.bashrc \
        $(HOME)/.bash_profile \
        $(HOME)/.zshrc \
        $(HOME)/.ideavimrc \
        $(HOME)/.vimrc \
        $(HOME)/.config/nvim/init.vim \
        $(HOME)/.config/nvim/coc-settings.json \
        $(HOME)/.config/alacritty/alacritty.yml
