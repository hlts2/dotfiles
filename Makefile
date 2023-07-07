DOTDIR := `pwd`

.PHONY: link
link:
	mkdir -p ${HOME}/.config
	ln -sfv $(DOTDIR)/zsh/zshrc    $(HOME)/.zshrc
	ln -sfv $(DOTDIR)/zsh/zshrc.d  $(HOME)/.zshrc.d
	ln -sfv $(DOTDIR)/zsh/p10k.zsh $(HOME)/.p10k.zsh
	ln -sfv $(DOTDIR)/nvim         $(HOME)/.config/nvim

.PHONY: unlink
unlink:
	unlink $(HOME)/.zshrc
	unlink $(HOME)/.zshrc.d
	unlink $(HOME)/.p10k.zsh
	unlink $(HOME)/.config/nvim
