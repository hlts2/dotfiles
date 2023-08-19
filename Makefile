DOTDIR := `pwd`

.PHONY: link
link:
	mkdir -p ${HOME}/.config
	mkdir -p ${HOME}/.config/aquaproj-aqua
	mkdkr -p ${HOME}/.config/alacritty
	ln -sfv $(DOTDIR)/zsh/zshrc                $(HOME)/.zshrc
	ln -sfv $(DOTDIR)/zsh/zshrc.d              $(HOME)/.zshrc.d
	ln -sfv $(DOTDIR)/zsh/p10k.zsh             $(HOME)/.p10k.zsh
	ln -sfv $(DOTDIR)/aqua/aqua.yaml           $(HOME)/.config/aquaproj-aqua/aqua.yaml
	ln -sfv $(DOTDIR)/alacritty/alacritty.yaml $(HOME)/.config/alacritty/alacritty.yaml
	ln -sfv $(DOTDIR)/nvim                     $(HOME)/.config/nvim

.PHONY: unlink
unlink:
	unlink $(HOME)/.zshrc
	unlink $(HOME)/.zshrc.d
	unlink $(HOME)/.p10k.zsh
	unlink $(HOME)/.config/aquaproj-aqua/aqua.yaml
	unlink $(HOME)/.config/alacritty/alacritty.yaml
	unlink $(HOME)/.config/nvim
