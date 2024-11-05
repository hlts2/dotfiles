DOTDIR := `pwd`

.PHONY: link
link:
	mkdir -p ${HOME}/.config
	mkdir -p ${HOME}/.config/aquaproj-aqua
	mkdir -p ${HOME}/.config/alacritty
	ln -sfv $(DOTDIR)/zsh/zshrc                $(HOME)/.zshrc
	ln -sfv $(DOTDIR)/zsh/zshrc.d              $(HOME)/.zshrc.d
	ln -sfv $(DOTDIR)/zsh/p10k.zsh             $(HOME)/.p10k.zsh
	ln -sfv $(DOTDIR)/aqua/aqua.yaml           $(HOME)/.config/aquaproj-aqua/aqua.yaml
	ln -sfv $(DOTDIR)/alacritty/alacritty.yaml $(HOME)/.config/alacritty/alacritty.yaml
	ln -sfv $(DOTDIR)/alacritty/alacritty.yaml $(HOME)/.config/alacritty/alacritty.toml
	ln -sfv $(DOTDIR)/tmux/tmux.conf           $(HOME)/.tmux.conf
	ln -sfv $(DOTDIR)/nvim                     $(HOME)/.config/nvim
	ln -sfv $(DOTDIR)/sway                     $(HOME)/.config/sway
	ln -sfv $(DOTDIR)/fcitx/config             $(HOME)/.config/fcitx/config
	ln -sfv $(DOTDIR)/fcitx/profile            $(HOME)/.config/fcitx/profile
	sudo ln -sfv $(DOTDIR)/misc/environment    /etc/environment

# .PHONY: tmp/link
# tmp/link:
# 	ln -sfv $(DOTDIR)/fcitx/config             $(HOME)/.config/fcitx/config
# 	ln -sfv $(DOTDIR)/fcitx/profile            $(HOME)/.config/fcitx/profile
#
# .PHONY: tmp/unlink
# tmp/unlink:
# 	unlink $(HOME)/.config/fcitx/config
# 	unlink $(HOME)/.config/fcitx/profile

.PHONY: unlink
unlink:
	unlink $(HOME)/.zshrc
	unlink $(HOME)/.zshrc.d
	unlink $(HOME)/.p10k.zsh
	unlink $(HOME)/.config/aquaproj-aqua/aqua.yaml
	unlink $(HOME)/.config/alacritty/alacritty.yaml
	unlink $(HOME)/.config/alacritty/alacritty.toml
	unlink $(HOME)/.tmux.conf
	unlink $(HOME)/.config/nvim
	unlink $(HOME)/.config/sway
	unlink $(HOME)/.config/fcitx/config
	unlink $(HOME)/.config/fcitx/profile
	sudo unlink /etc/environment
