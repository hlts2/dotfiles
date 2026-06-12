DOTDIR := `pwd`
ARCH_DIR := $(DOTDIR)/linux/arch

# Idempotent symlink:
#   -s create symbolic
#   -f force (replace existing file/symlink)
#   -n do NOT dereference: if dst is a symlink to a dir, treat as plain target
#      (avoids creating sway/sway etc. when rerunning `make link`)
#   -v verbose
SYMLINK := ln -sfnv
SUDO_SYMLINK := sudo ln -sfnv

# Directories under $(HOME)/.config/ that are linked whole-directory to
# $(DOTDIR)/<name>. Add new apps here — no further Makefile edits needed.
CONFIG_DIRS := \
  alacritty \
  atuin \
  fcitx \
  ghostty \
  gwq \
  herdr \
  hunk \
  niri \
  nvim \
  nwg-drawer \
  nwg-launchers \
  nwg-look \
  mise \
  sway \
  swaylock \
  swaync \
  waybar \
  workmux \
  xremap \
  yazi

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
	mkdir -p $(HOME)/.config
	# Files that live directly under $HOME.
	$(SYMLINK) $(DOTDIR)/zsh/zshrc    $(HOME)/.zshrc
	$(SYMLINK) $(DOTDIR)/zsh/zimrc    $(HOME)/.zimrc
	$(SYMLINK) $(DOTDIR)/zsh/zshrc.d  $(HOME)/.zshrc.d
	$(SYMLINK) $(DOTDIR)/zsh/p10k.zsh $(HOME)/.p10k.zsh
	$(SYMLINK) $(DOTDIR)/tmux/tmux.conf $(HOME)/.tmux.conf
	# Whole-directory links under ~/.config/ (add new apps to CONFIG_DIRS).
	# If a real (non-symlink) directory already exists at the target, it is
	# renamed to <name>.bak first so user data is never overwritten.
	for d in $(CONFIG_DIRS); do \
	  target="$(HOME)/.config/$$d" ; \
	  if [ -d "$$target" ] && [ ! -L "$$target" ]; then \
	    echo ">>> backing up $$target -> $$target.bak" ; \
	    mv "$$target" "$$target.bak" ; \
	  fi ; \
	  $(SYMLINK) $(DOTDIR)/$$d "$$target" ; \
	done
	# System-wide.
	$(SUDO_SYMLINK) $(DOTDIR)/misc/environment /etc/environment

.PHONY: unlink
unlink:
	for p in \
	  $(HOME)/.zshrc \
	  $(HOME)/.zimrc \
	  $(HOME)/.zshrc.d \
	  $(HOME)/.p10k.zsh \
	  $(HOME)/.tmux.conf \
	; do \
	  if [ -L "$$p" ]; then rm -fv "$$p"; fi; \
	done
	for d in $(CONFIG_DIRS); do \
	  if [ -L "$(HOME)/.config/$$d" ]; then rm -fv "$(HOME)/.config/$$d"; fi; \
	done
	if [ -L /etc/environment ]; then sudo rm -fv /etc/environment; fi
