# Ghostty Auto-launch tmux Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Open a Ghostty window and land directly inside a fresh tmux session, with logic confined to shell + ghostty configuration only.

**Architecture:** Define a zsh function `ghostty-launch` in `zsh/zshrc.d/tmux-autoattach.zsh` (sourced by `zshrc` so it is also callable from interactive shells). Ghostty's `command` directive invokes the function via `zsh -c`, which `exec`s tmux. Per Ghostty window = one new tmux session, named by tmux's default auto-numbering. No fallback when tmux is missing — function is a no-op.

**Tech Stack:** zsh, tmux, Ghostty.

**Spec:** `docs/superpowers/specs/2026-05-09-ghostty-tmux-autolaunch-design.md`

**Repo conventions:**
- Dotfiles repo. `make link` already symlinks `zsh/zshrc.d/` → `~/.zshrc.d/` and `ghostty/` → `~/.config/ghostty/`. No Makefile change needed; new files in those directories are visible to the system as soon as they exist.
- Single commit at end (spec): `feat(ghostty): auto-launch tmux via ghostty-launch`.

---

## Task 1: Create the `ghostty-launch` function file

**Files:**
- Create: `zsh/zshrc.d/tmux-autoattach.zsh`

- [ ] **Step 1: Create the file**

Path: `zsh/zshrc.d/tmux-autoattach.zsh`

Contents:

```sh
# Entry point invoked by Ghostty's `command` directive.
# Replaces the current shell with tmux when available; no-op otherwise.
function ghostty-launch {
    (( $+commands[tmux] )) && exec tmux new-session
}
```

- [ ] **Step 2: Verify the file is reachable through the existing symlink**

Run: `readlink -f ~/.zshrc.d/tmux-autoattach.zsh`

Expected output: an absolute path ending in `dotfiles/zsh/zshrc.d/tmux-autoattach.zsh`. (`~/.zshrc.d` is a symlink to `dotfiles/zsh/zshrc.d`, so the new file is exposed without `make link`.)

If the readlink fails or points elsewhere, stop — the symlink is broken and `make link` must be rerun before continuing.

---

## Task 2: Wire the function file into `zshrc`

**Files:**
- Modify: `zsh/zshrc`

- [ ] **Step 1: Insert the source line after `function.zsh`**

Current `zsh/zshrc` lines 11-18:

```sh
source $HOME/.zshrc.d/history.zsh
source $HOME/.zshrc.d/completion.zsh
source $HOME/.zshrc.d/export.zsh
source $HOME/.zshrc.d/alias.zsh
source $HOME/.zshrc.d/function.zsh
source $HOME/.zshrc.d/theme.zsh
source $HOME/.zshrc.d/plugin.zsh
source $HOME/.zshrc.d/tools.zsh
```

Edit so the result is:

```sh
source $HOME/.zshrc.d/history.zsh
source $HOME/.zshrc.d/completion.zsh
source $HOME/.zshrc.d/export.zsh
source $HOME/.zshrc.d/alias.zsh
source $HOME/.zshrc.d/function.zsh
source $HOME/.zshrc.d/tmux-autoattach.zsh
source $HOME/.zshrc.d/theme.zsh
source $HOME/.zshrc.d/plugin.zsh
source $HOME/.zshrc.d/tools.zsh
```

Use the Edit tool with:
- `old_string`: `source $HOME/.zshrc.d/function.zsh\nsource $HOME/.zshrc.d/theme.zsh`
- `new_string`: `source $HOME/.zshrc.d/function.zsh\nsource $HOME/.zshrc.d/tmux-autoattach.zsh\nsource $HOME/.zshrc.d/theme.zsh`

(Substitute literal newlines for `\n` when invoking the tool.)

- [ ] **Step 2: Verify the function is defined in a fresh interactive zsh**

Run: `zsh -ic 'whence -v ghostty-launch'`

Expected output (one line): `ghostty-launch is a shell function`.

If the output is `ghostty-launch not found`, the source line did not take effect — re-check Task 1 file contents and Task 2 source line.

- [ ] **Step 3: Verify the function does not run anything at definition time**

Run: `zsh -ic 'echo ok'`

Expected output: `ok` (and no tmux processes spawned). Confirms sourcing the file is side-effect free — defining the function alone must not start tmux.

You can additionally check no new tmux session was created: `tmux ls 2>/dev/null` (its output should be unchanged from before this task).

---

## Task 3: Add Ghostty's `command` directive

**Files:**
- Modify: `ghostty/config`

- [ ] **Step 1: Append the command directive at the end of the file**

`ghostty/config` currently ends with the bright color palette (lines 52-60). Append a new section at end of file:

```

# Shell
command = zsh -c '. ~/.zshrc.d/tmux-autoattach.zsh && ghostty-launch'
```

Note: leading blank line separates from the previous section. Use the Edit tool with:
- `old_string`: `palette = 15=#d2d4de`
- `new_string`: `palette = 15=#d2d4de\n\n# Shell\ncommand = zsh -c '. ~/.zshrc.d/tmux-autoattach.zsh && ghostty-launch'`

(Substitute literal newlines for `\n` when invoking the tool.)

- [ ] **Step 2: Verify the file is well-formed**

Run: `tail -5 ~/.config/ghostty/config`

Expected last 4 lines:

```
palette = 15=#d2d4de

# Shell
command = zsh -c '. ~/.zshrc.d/tmux-autoattach.zsh && ghostty-launch'
```

(`~/.config/ghostty` is symlinked to the repo, so editing `ghostty/config` directly is reflected.)

---

## Task 4: Manual end-to-end verification

These steps require human interaction with a desktop. Execute them yourself and only proceed after each one passes.

- [ ] **Step 1: Open a new Ghostty window**

From any launcher / keybinding, open Ghostty.

Expected:
- The window opens directly into tmux. The status line at the bottom shows `[0] 0:zsh*` (or similar — tmux session name `0`, window 0).
- Inside the new window, run `echo $TMUX`. Expected: a non-empty path like `/tmp/tmux-1000/default,12345,0`.

If the window opens to plain zsh (no tmux), check:
1. `which tmux` — must resolve.
2. `cat ~/.config/ghostty/config | tail` — `command = ...` line is present.
3. Restart Ghostty fully (the `command` directive only takes effect on new surfaces; some Ghostty versions cache configs at process start).

- [ ] **Step 2: Open a second Ghostty window and verify it gets a separate session**

Open another Ghostty window.

Run inside it: `tmux ls`

Expected output: two lines, one per session — e.g.

```
0: 1 windows (created Sat May  9 ...)
1: 1 windows (created Sat May  9 ...) (attached)
```

Confirms each Ghostty window has its own auto-numbered session.

- [ ] **Step 3: Verify non-Ghostty zsh is unaffected**

In an existing terminal that is not Ghostty (alacritty, tty, or a tmux pane that was already open), run: `zsh`

Expected: a plain nested zsh prompt, no tmux auto-launch, no error. The function `ghostty-launch` should be defined (`whence -v ghostty-launch` → `is a shell function`) but not invoked.

`exit` to leave the nested zsh.

- [ ] **Step 4: Verify the manual escape hatch**

In an existing non-tmux interactive zsh (e.g. open a tty / alacritty session and run `zsh`), run: `ghostty-launch`

Expected: the current shell is replaced by tmux; `tmux ls` now shows another session.

`exit` the tmux session to clean up.

- [ ] **Step 5: Verify detach behavior in Ghostty**

In a Ghostty-launched tmux session, press `prefix d` (default `Ctrl-b d`).

Expected: tmux client exits → Ghostty surface shows the close-confirmation dialog (because `confirm-close-surface = true`).

Cancel or confirm as you prefer; this is just to verify the dialog appears (i.e. tmux's exit propagates correctly to Ghostty).

---

## Task 5: Commit

- [ ] **Step 1: Stage the three changes**

Run:

```
git add zsh/zshrc.d/tmux-autoattach.zsh zsh/zshrc ghostty/config
```

- [ ] **Step 2: Confirm only the intended files are staged**

Run: `git status --short`

Expected (order may vary):

```
A  zsh/zshrc.d/tmux-autoattach.zsh
M  zsh/zshrc
M  ghostty/config
```

Plus any pre-existing untracked entries (e.g. `?? .claude/`) that you should NOT stage.

If something else is staged, `git restore --staged <file>` it before committing.

- [ ] **Step 3: Commit**

Run:

```
git commit -m "$(cat <<'EOF'
feat(ghostty): auto-launch tmux via ghostty-launch

Define ghostty-launch in zsh/zshrc.d/tmux-autoattach.zsh and invoke it
from ghostty/config's command directive. Each Ghostty window starts
its own tmux session (default auto-numbering). No-op when tmux is
missing.
EOF
)"
```

- [ ] **Step 4: Verify the commit**

Run: `git log -1 --stat`

Expected: 1 commit, 3 files changed (1 new file + 2 modifications), summary line `feat(ghostty): auto-launch tmux via ghostty-launch`.

---

## Out-of-scope reminders

Do not, in this plan:
- Add fallback behavior for missing tmux (spec rejects defensive code).
- Add session naming logic, cwd-based smart attach, etc.
- Touch `Makefile`, `bin/`, alacritty, or other launchers.
- Modify `tses` / `ghqcd` in `function.zsh`.

If a "while I'm here" itch arises in those areas, file it as a separate follow-up rather than mixing into this commit.
