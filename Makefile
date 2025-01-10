DOTDIR := `pwd`

.PHONY: link
link:
	mkdir -p ${HOME}/.config
	mkdir -p ${HOME}/.config/aquaproj-aqua
	mkdir -p ${HOME}/.config/alacritty
	mkdir -p ${HOME}/.config/xremap
	ln -sfv $(DOTDIR)/zsh/zshrc                $(HOME)/.zshrc
	ln -sfv $(DOTDIR)/zsh/zshrc.d              $(HOME)/.zshrc.d
	ln -sfv $(DOTDIR)/zsh/p10k.zsh             $(HOME)/.p10k.zsh
	ln -sfv $(DOTDIR)/aqua/aqua.yaml           $(HOME)/.config/aquaproj-aqua/aqua.yaml
	ln -sfv $(DOTDIR)/alacritty/alacritty.yaml $(HOME)/.config/alacritty/alacritty.yaml
	ln -sfv $(DOTDIR)/alacritty/alacritty.toml $(HOME)/.config/alacritty/alacritty.toml
	ln -sfv $(DOTDIR)/tmux/tmux.conf           $(HOME)/.tmux.conf
	ln -sfv $(DOTDIR)/nvim                     $(HOME)/.config/nvim
	ln -sfv $(DOTDIR)/sway                     $(HOME)/.config/sway
	ln -sfv $(DOTDIR)/swaync                   $(HOME)/.config/swaync
	ln -sfv $(DOTDIR)/swaylock                 $(HOME)/.config/swaylock
	ln -sfv $(DOTDIR)/waybar                   $(HOME)/.config/waybar
	ln -sfv $(DOTDIR)/nwg-drawer               $(HOME)/.config/nwg-drawer
	ln -sfv $(DOTDIR)/nwg-launchers            $(HOME)/.config/nwg-launchers
	ln -sfv $(DOTDIR)/nwg-look                 $(HOME)/.config/nwg-look
	ln -sfv $(DOTDIR)/xremap/config.yaml       $(HOME)/.config/xremap/config.yaml
	ln -sfv $(DOTDIR)/fcitx/config             $(HOME)/.config/fcitx/config
	ln -sfv $(DOTDIR)/fcitx/profile            $(HOME)/.config/fcitx/profile
	sudo ln -sfv $(DOTDIR)/misc/environment    /etc/environment

# .PHONY: tmp/link
# tmp/link:
# 	mkdir -p ${HOME}/.config/xremap
# 	ln -sfv $(DOTDIR)/xremap/config.yaml       $(HOME)/.config/xremap/config.yaml
#
# .PHONY: tmp/unlink
# tmp/unlink:
# 	unlink $(HOME)/.config/xremap/config.yaml

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
	unlink $(HOME)/.config/swaync
	unlink $(HOME)/.config/swaylock
	unlink $(HOME)/.config/waybar
	unlink $(HOME)/.config/nwg-drawer
	unlink $(HOME)/.config/nwg-launchers
	unlink $(HOME)/.config/nwg-look
	unlink $(HOME)/.config/xremap/config.yaml
	unlink $(HOME)/.config/fcitx/config
	unlink $(HOME)/.config/fcitx/profile
	sudo unlink /etc/environment
