# Ghostty Auto-launch tmux — Design

Date: 2026-05-09
Branch: feat/add-setup
Scope: `ghostty/`, `zsh/`

## Goal

Open a Ghostty window and land directly inside a fresh tmux session. Implementation must be self-contained in shell + Ghostty configuration only — no wrapper scripts under `bin/`, no Makefile changes.

## Behavioral requirements

- **Per-window session**: each Ghostty window starts a new tmux session. No shared `main` session.
- **Session naming**: tmux's default auto-numbering (`0`, `1`, `2`, ...). No custom naming.
- **Trigger surface**: Ghostty only. Other launchers (alacritty, tty, ssh) must not auto-launch tmux.
- **Manual escape hatch**: a function callable from any interactive shell to convert that shell into a tmux session.
- **Missing tmux**: function is a no-op. tmux is a guaranteed invariant in this environment, so no fallback shell is provisioned.

## Approach

Hybrid: a zsh function defined in `zsh/zshrc.d/tmux-autoattach.zsh`, invoked explicitly by Ghostty's `command` directive. The function is also sourced by `zshrc` so it is available in interactive shells.

Rejected alternatives:

- **Ghostty `command = tmux new-session`**: works, but pushes fallback / future logic into Ghostty config where shell-style branching is awkward.
- **Auto-detect `$GHOSTTY_BIN_DIR` in zshrc and `exec tmux`**: works, but trigger is implicit (env sniffing) and runs a check on every zsh start.

The hybrid keeps the trigger explicit (visible in `ghostty/config`), keeps the logic in shell (where extension is natural), and leaves non-Ghostty zsh sessions untouched.

## File layout

| File | Change |
|---|---|
| `zsh/zshrc.d/tmux-autoattach.zsh` | **New**. Defines `ghostty-launch`. |
| `zsh/zshrc` | Add `source $HOME/.zshrc.d/tmux-autoattach.zsh` after `function.zsh`. |
| `ghostty/config` | Add `command = zsh -c '. ~/.zshrc.d/tmux-autoattach.zsh && ghostty-launch'`. |

`zsh/zshrc.d` and `ghostty/` are already linked by `make link` (`CONFIG_DIRS` plus the explicit `~/.zshrc.d` symlink). No Makefile change required.

### `zsh/zshrc` source ordering

```text
source $HOME/.zshrc.d/history.zsh
source $HOME/.zshrc.d/completion.zsh
source $HOME/.zshrc.d/export.zsh
source $HOME/.zshrc.d/alias.zsh
source $HOME/.zshrc.d/function.zsh
source $HOME/.zshrc.d/tmux-autoattach.zsh   ← NEW
source $HOME/.zshrc.d/theme.zsh
source $HOME/.zshrc.d/plugin.zsh
source $HOME/.zshrc.d/tools.zsh
```

The position is semantic (next to `function.zsh`); the file only defines a function, so any position works.

## Function specification

`zsh/zshrc.d/tmux-autoattach.zsh`:

```sh
# Entry point invoked by Ghostty's `command` directive.
function ghostty-launch {
    (( $+commands[tmux] )) && exec tmux new-session
}
```

Behavior:

| Condition | Result |
|---|---|
| `tmux` on `$PATH` | `exec tmux new-session` — current process is replaced; tmux owns the surface. |
| `tmux` missing | Function returns. `zsh -c` exits 0. Ghostty closes the surface. |

`exec` ensures tmux becomes Ghostty's direct child — no leftover `zsh -c` parent.

## Ghostty wiring

`ghostty/config` (append):

```
command = zsh -c '. ~/.zshrc.d/tmux-autoattach.zsh && ghostty-launch'
```

- `zsh -c` does **not** read `~/.zshrc`. Only the autoattach file is sourced, keeping launch fast and isolated.
- `&&` short-circuits if the source step fails (e.g., file missing).
- The full `zshrc` runs once per tmux pane (when tmux spawns its first shell), as expected.

## Edge cases

| Case | Behavior |
|---|---|
| Manual `zsh` inside a tmux pane | Plain nested zsh. `ghostty-launch` is not auto-invoked. |
| Manual `ghostty-launch` in an interactive shell | Current shell is replaced by tmux — intentional escape hatch. |
| Non-Ghostty terminal (alacritty, tty) | autoattach file is sourced but only defines a function. No tmux trigger. |
| ssh from local Ghostty | Remote shell is unaffected (the ghostty `command` is local-only). |
| tmux detach / exit inside Ghostty | tmux client exits → `zsh -c` exits → Ghostty closes the surface (`confirm-close-surface = true` shows the close dialog). |
| `~/.zshrc.d/tmux-autoattach.zsh` deleted | `.` (source) fails, `&&` blocks `ghostty-launch`, `zsh -c` exits non-zero, Ghostty closes — fail loud. |

## Verification

1. New file is symlinked: `ls -l ~/.zshrc.d/tmux-autoattach.zsh` resolves into the dotfiles repo.
2. Function is loaded in interactive shells: `which ghostty-launch` in a fresh zsh prints the function body.
3. Open a new Ghostty window → land in tmux. `tmux ls` shows session `0`.
4. Open a second Ghostty window → `tmux ls` shows `0` and `1` (independent sessions).
5. `tses` / `ghqcd` continue to work inside the auto-launched tmux session.
6. Open alacritty (or another terminal) → no tmux is auto-attached.
7. Detach (prefix-d) inside tmux → Ghostty's close-confirmation dialog appears.

## Out of scope

- Custom session naming (cwd-based, project-based, etc.).
- Smart "attach to existing matching session, else create" logic.
- Applying the same behavior to other terminals (alacritty).
- Migration of the existing `tses` / `ghqcd` workflow.

## Commit plan

Single commit: `feat(ghostty): auto-launch tmux via ghostty-launch`.
