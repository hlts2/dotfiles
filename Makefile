DOTDIR := `pwd`
ARCH_DIR := $(DOTDIR)/linux/arch

# ── Arch: configurable inputs ──
# Wallpaper file (inside $(ARCH_DIR)/etc/greetd/) used as the ReGreet background.
# Installed to /etc/greetd/background.jpg with a fixed name so regreet.toml is stable.
GREETD_WALLPAPER ?= minimal-triangles.jpg

# ── Arch: install packages from tracked lists ──
.PHONY: arch/packages/install
arch/packages/install: arch/packages/install-pacman arch/packages/install-aur

.PHONY: arch/packages/install-pacman
arch/packages/install-pacman:
	sudo pacman -S --needed - < $(ARCH_DIR)/packages/pacman.txt

.PHONY: arch/packages/install-aur
arch/packages/install-aur:
	paru -S --needed - < $(ARCH_DIR)/packages/aur.txt

# ── Arch: export current package list to tracked files ──
.PHONY: arch/packages/export
arch/packages/export:
	pacman -Qqen > $(ARCH_DIR)/packages/pacman.txt
	pacman -Qqem > $(ARCH_DIR)/packages/aur.txt

.PHONY: arch/dm/use-greetd
arch/dm/use-greetd:
	sudo systemctl disable sddm.service || true
	sudo systemctl enable greetd.service

# ── Arch: install greetd config files ──
# Uses `install` (copy) rather than symlink because the greeter user cannot
# traverse into /home/hlts2 (drwx------), so symlinks pointing into the
# dotfiles repo would be unreadable from the login screen.
.PHONY: arch/dm/setup
arch/dm/setup:
	sudo install -D -m 644 $(ARCH_DIR)/etc/greetd/config.toml    /etc/greetd/config.toml
	sudo install -D -m 644 $(ARCH_DIR)/etc/greetd/sway.cfg       /etc/greetd/sway.cfg
	sudo install -D -m 644 $(ARCH_DIR)/etc/greetd/regreet.toml   /etc/greetd/regreet.toml
	sudo install -D -m 644 $(ARCH_DIR)/etc/greetd/regreet.css    /etc/greetd/regreet.css
	sudo install -D -m 644 $(ARCH_DIR)/etc/greetd/$(GREETD_WALLPAPER) /etc/greetd/background.jpg

.PHONY: link
link:
	mkdir -p ${HOME}/.config
	mkdir -p ${HOME}/.config/aquaproj-aqua
	mkdir -p ${HOME}/.config/alacritty
	mkdir -p ${HOME}/.config/xremap
	mkdir -p ${HOME}/.config/workmux
	mkdir -p ${HOME}}/.config/gwq
	mkdir -p ${HOME}}/.config/ghostty
	mkdir -p ${HOME}/.config/yazi
	ln -sfv $(DOTDIR)/zsh/zshrc                $(HOME)/.zshrc
	ln -sfv $(DOTDIR)/zsh/zimrc                $(HOME)/.zimrc
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
	ln -sfv $(DOTDIR)/workmux/config.yaml      $(HOME)/.config/workmux/config.yaml
	ln -sfv $(DOTDIR)/gwq/config.toml          $(HOME)/.config/gwq/config.toml
	ln -sfv $(DOTDIR)/ghostty/config           $(HOME)/.config/ghostty/config
	ln -sfv $(DOTDIR)/yazi/yazi.toml           $(HOME)/.config/yazi/yazi.toml
	sudo ln -sfv $(DOTDIR)/misc/environment    /etc/environment

# .PHONY: tmp/link
# tmp/link:
# 	mkdir -p ${HOME}/.config/yazi
# 	ln -sfv $(DOTDIR)/yazi/yazi.toml           $(HOME)/.config/yazi/yazi.toml
#
# .PHONY: tmp/unlink
# tmp/unlink:
# 	unlink $(HOME)/.config/yazi/yazi.toml

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
	unlink $(HOME)/.config/workmux/config.yaml
	unlink $(HOME)/.config/gwq/config.toml
	unlink $(HOME)/.config/ghostty/config
	unlink $(HOME)/.config/yazi/yazi.toml
	sudo unlink /etc/environment
