# Refactor Proposals

Review date: 2026-05-09

This document summarizes refactoring ideas for this dotfiles repository based on the current tree. The priority is to improve maintainability, reproducibility, and reviewability without changing runtime behavior unnecessarily.

## Current State

- `Makefile` is the main setup entry point. It handles `link`, `unlink`, Arch package operations, and greetd installation.
- Most `~/.config` entries are linked as whole directories. The target list is centralized in `CONFIG_DIRS` in `Makefile`.
- The Wayland setup currently keeps both SwayFX and Niri. The README positions Niri + noctalia-shell as the primary setup, with Sway-era UI configs kept as fallback.
- zsh, tmux, and Neovim are already split into smaller files, but some machine-specific values and generated-state-like files are still mixed into tracked configuration.

## Priority A: Low Risk, High Value

### 1. Move Link Definitions Into a Manifest

Targets:

- `Makefile`
- Candidate new file: `links.toml` or `links.mk`

The current `Makefile` stores both the execution logic and the data describing what should be linked. This is still readable at the current size, but it will get noisier as more applications are added.

Proposal:

- Split link data into groups: `~/.config` directories, files under `$HOME`, and system-wide files.
- Keep `Makefile` as the thin execution layer that applies those definitions.
- As a first step, staying within Make and splitting the data into `CONFIG_DIRS`, `HOME_FILES`, and `SYSTEM_FILES` is enough.

Expected impact:

- Adding a new app config becomes more obvious.
- `unlink` is less likely to drift from `link`.
- Future migration to chezmoi, stow, or a small custom script becomes easier because the source data is already separated.

Notes:

- Preserve the current behavior where `link` backs up existing real directories to `<name>.bak`.
- Keep `/etc/environment` separate from normal link targets because it requires sudo and can affect system-wide behavior.

### 2. Replace `DOTDIR := \`pwd\`` With `$(CURDIR)`

Target:

- `Makefile`

`DOTDIR := \`pwd\`` relies on shell command substitution. Make already exposes the current working directory as `$(CURDIR)`, which is clearer and avoids shell-specific evaluation.

Proposal:

```make
DOTDIR := $(CURDIR)
ARCH_DIR := $(DOTDIR)/linux/arch
```

Expected impact:

- Variable evaluation is clearer.
- The Makefile contains less shell syntax.

### 3. Make Neovim Plugin Loader Failures Visible

Targets:

- `nvim/lua/plugins/init.lua`
- `nvim/lua/plugins/lsp/`

`nvim/lua/plugins/init.lua` currently wraps plugin spec imports with `pcall(require, ...)`, which silently ignores missing or broken plugin files. In particular, the `lsp` category lists `"tool-installer"`, but `nvim/lua/plugins/lsp/tool-installer.lua` does not currently exist.

Proposal:

- Emit a warning when a plugin module is missing or fails to load.
- Distinguish required plugin specs from optional ones.
- Remove `tool-installer` from the list if it is not used, or add the missing file if it is intended.

Expected impact:

- Typos and accidental plugin file deletions become visible immediately.
- Startup-speed and plugin-cleanup work becomes safer because missing functionality is less likely to go unnoticed.

### 4. Split Shell Environment Variables by Scope

Targets:

- `zsh/zshrc.d/export.zsh`
- Candidate new file: `zsh/zshrc.d/export.local.zsh.example`

`export.zsh` currently mixes general shell settings, Go settings, private organization names, CPU-specific compiler flags, and ssh-agent startup logic. Personal and work-specific values reduce portability and make the public/private boundary unclear.

Proposal:

- Keep general settings together: locale, XDG, editor, and base PATH values.
- Move language-specific settings into focused files: Go, Bun, Wasm, Krew, etc.
- Move personal or work-specific values such as `GOPRIVATE` into `export.local.zsh`, and ignore that file in Git.
- Move ssh-agent startup into `ssh-agent.zsh`, and make the implementation match the comment about login-shell behavior.

Expected impact:

- Environment-dependent values become easier to reason about.
- New-machine setup becomes clearer because local customization points are explicit.

## Priority B: Medium-Sized Cleanup

### 5. Create a Sway/Niri Keybinding Map

Targets:

- `sway/config.d/default`
- `niri/config.kdl`
- Candidate new file: `docs/keybindings.md`

Sway and Niri are clearly intended to have similar ergonomics. The Niri config already includes several `matches sway` comments. Since the config languages and window-management models differ, a shared generator is probably not worth it yet. A manual compatibility map is a better first step.

Proposal:

- Document mappings for terminal, launcher, lock, notifications, focus, move, workspaces, media, brightness, and clipboard.
- Mark bindings that only exist in one compositor as `niri-only` or `sway-only`.
- Start with a hand-maintained document instead of trying to generate it from config files.

Expected impact:

- Moving further toward Niri as the primary environment becomes easier.
- If Sway remains a fallback, the expected level of compatibility is explicit.

### 6. Define the Role of Sway Fallback Configs

Targets:

- `sway/`
- `waybar/`
- `swaync/`
- `swaylock/`
- `nwg-launchers/`
- `README.md`

The README says Sway-era UI configs are kept as fallback. Some config comments still reflect an in-progress transition to noctalia-shell, and old autostart entries remain around.

Proposal:

- Add `docs/sway-fallback.md` that defines what is actually supported as fallback.
- Move unused configs to `legacy/`, or clearly document that they are kept for reference only.
- Review startup differences between `sway/config.d/autostart_applications` and `niri/config.kdl`.

Expected impact:

- It becomes clearer whether Niri or SwayFX is the primary environment.
- Less effort is spent maintaining configs that are no longer part of the active setup.

### 7. Classify Generated or State-Like Files

Targets:

- `fcitx/profile`
- `nvim/lazy-lock.json`
- `hunk/state.json`

`fcitx/profile` contains a very large list of disabled input methods, which makes review difficult. `lazy-lock.json` is a useful tracked lock file, but files such as `state.json` should be clearly categorized as either user-edited configuration or generated state.

Proposal:

- Classify tracked files as either hand-edited configuration, generated-but-important lock data, or local app state.
- For tracked generated files, document the update command and review expectations.
- Move unimportant local state files into `.gitignore`.

Expected impact:

- Reviews focus on meaningful changes.
- App-generated churn becomes less distracting.

## Priority C: Tooling and Process

### 8. Add Validation Make Targets

Targets:

- `Makefile`
- shell scripts
- Neovim Lua
- compositor configs

Dotfiles repositories are easy to break accidentally, and many failures only appear after login or app startup. A local `make check` target would provide a basic safety net.

Proposal:

- `make check`: run all lightweight validation checks.
- `make check/shell`: run `shellcheck` on shell scripts.
- `make check/nvim`: avoid a heavy plugin sync at first; start with a headless load check such as `nvim --headless "+lua require('init')" +qa`.
- `make check/make`: run `make -n link` and `make -n unlink` to inspect recipe expansion.
- `make check/niri`: run `niri validate` when available.

Expected impact:

- Basic breakage can be caught before applying dotfiles on a machine.
- New-machine migration becomes less risky.

### 9. Split Setup Docs by OS and Privilege Boundary

Targets:

- `README.md`
- `Makefile`
- `bin/install-nix.sh`
- `bin/uninstall-nix.sh`
- `linux/arch/`

The README is currently clear for the Arch Linux path. The repository also contains Nix installer scripts and a Lima Ubuntu config, so setup responsibilities would be clearer if they were split by platform and privilege boundary.

Proposal:

- Add `docs/setup/arch.md`.
- Add `docs/setup/nix.md`.
- Add `docs/setup/lima-ubuntu.md`.
- Keep README focused on the shortest setup path and the repository layout.

Expected impact:

- New-machine setup requires reading less unrelated material.
- OS-specific differences are less likely to leak into unrelated Make targets.

### 10. Document Theme Values as Small Design Tokens

Targets:

- `ghostty/config`
- `tmux/tmux.conf`
- `waybar/style.css`
- `nwg-*/style.css`
- `sway/config.d/theme`
- `niri/config.kdl`

Colors, fonts, opacity, and accent values are spread across several application-specific formats. Full automatic generation is probably not worth doing immediately, but documenting the canonical values would still help.

Proposal:

- Add `docs/theme.md` with the current font, terminal palette, accent color, and opacity values.
- Do not start with generation. First define which values are authoritative.
- Add templating later only if manual synchronization becomes painful.

Expected impact:

- Theme changes become easier to plan.
- Visual differences between terminal, tmux, and compositor configs become intentional.

## Recommended Order

1. Change `Makefile` to use `DOTDIR := $(CURDIR)`.
2. Add Neovim plugin loader warnings, or remove the unused `tool-installer` entry.
3. Split `zsh/zshrc.d/export.zsh` and add `export.local.zsh.example`.
4. Create `docs/keybindings.md`.
5. Add a minimal `make check`.
6. Document the tracking policy for generated/state files.
7. Define the support boundary for Sway fallback configs.

## Defer for Now

- Auto-generating Sway and Niri configs. The config languages and window-management models differ enough that a generator would likely add operational cost too early.
- Migrating wholesale to a dotfiles manager. The current Makefile is still small, so a full migration would add more risk than value right now.
- Automatically synchronizing every theme value. Each application represents colors differently, so documentation should come before generation.

