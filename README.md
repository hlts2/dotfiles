# dotfiles

Personal configuration repository managed via a Makefile.

## Stack

- **OS**: Arch Linux
- **Compositor**: SwayFX / Niri (Wayland)
- **Shell UI**: [noctalia-shell](https://github.com/noctalia-dev/noctalia-shell) (bar/notif/lock/OSD/launcher/wallpaper)
- **Login manager**: greetd + regreet
- **Input method**: fcitx5 + mozc
- **Shell**: zsh (Zim plugin manager) + powerlevel10k
- **Terminal**: ghostty (fallback: alacritty)
- **Multiplexer**: tmux
- **Editor**: Neovim (lazy.nvim)
- **File manager**: Thunar (GUI) / yazi (terminal)
- **Launcher**: fuzzel / nwg-drawer
- **Legacy Sway UI (fallback)**: waybar / swaync / swaylock / nwgbar

## Quick setup (new machine)

```sh
# 1. Install packages
make arch/packages/install

# 2. Link dotfiles into $HOME / ~/.config
make link

# 3. Install greetd config (regreet + wallpaper)
make arch/dm/setup
```

## Makefile targets

### Linking
| Target | Description |
|---|---|
| `make link` | Create all symlinks (idempotent, rerunnable) |
| `make unlink` | Remove all symlinks (only touches actual symlinks) |

### Arch package tracking
| Target | Description |
|---|---|
| `make arch/packages/install` | Install every package listed in `linux/arch/packages/` |
| `make arch/packages/install-pacman` | Native + Chaotic-AUR only |
| `make arch/packages/install-aur` | AUR-built only |
| `make arch/packages/export` | Snapshot current `pacman -Qqen/-Qqem` into tracked files |

### Display manager
| Target | Description |
|---|---|
| `make arch/dm/setup` | Install `/etc/greetd/{config.toml,sway.cfg,regreet.toml,regreet.css,background.jpg}` (copy, not symlink) |
| `make arch/dm/use-greetd` | Switch systemd's display-manager to greetd |

## Layout

```
.
├── Makefile                # Entry point; targets for linking and Arch setup
├── linux/arch/
│   ├── packages/           # pacman.txt / aur.txt — tracked explicit packages
│   └── etc/greetd/         # greetd + regreet config + login wallpaper
├── zsh/                    # ~/.zshrc, ~/.zshrc.d, ~/.p10k.zsh, ~/.zimrc
├── tmux/                   # ~/.tmux.conf
├── nvim/                   # ~/.config/nvim
├── sway/ niri/             # compositor configs (~/.config/{sway,niri})
├── swaync/ swaylock/ waybar/ nwg-*/   # legacy Sway-era UI configs (kept as fallback)
├── ghostty/ alacritty/     # terminal emulators
├── fcitx/                  # IME
├── gwq/ workmux/ yazi/ xremap/   # misc CLI tools
└── misc/environment        # /etc/environment (pam_env)
```

Whole-directory entries under `~/.config/` are enumerated in `Makefile:CONFIG_DIRS`.
Adding a new app is a one-line change there.

## Notes

- **Idempotency**: `make link` uses `ln -sfnv` and backs up pre-existing real directories to `<name>.bak` before linking.
- **greetd files are copied, not symlinked**: the greeter user cannot traverse `/home/hlts2` (mode 700), so configs are installed with `install -m 644`. Rerun `make arch/dm/setup` after editing them.
- **Chaotic-AUR packages** land in `pacman.txt` (not `aur.txt`), because `pacman -Qqem` only lists packages whose repo is not in the sync DB.
