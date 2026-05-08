# Neovim Startup Speedup — Design

- **Date**: 2026-05-08
- **Branch**: `feat/add-setup`
- **Scope**: `nvim/` (Neovim configuration)

## Problem

Neovim feels slow to launch. The user has not measured it yet, but the cold-start delay is noticeable. Out of scope: the freeze that happens when opening Rust projects (will be handled in a separate brainstorming session).

## Goal

Shorten Neovim's cold-start time without changing the visible behavior or feature set.

## Success Criteria

- `vim.loader.enable()` is enabled at the top of `init.lua`.
- `dashboard-nvim` and `nvim-treesitter/playground` are removed.
- All plugins currently loaded eagerly are converted to lazy loading via `event` / `cmd` / `ft` / `keys`, except where lazy loading is known to break the plugin (notably `rustaceanvim`).
- `nvim --startuptime` is measured 5 times before and 5 times after the change. **Target: ≥30% reduction in average startup time.** The exact ms target is set after the baseline is captured.
- All visible appearance is preserved: tokyonight-storm colorscheme, lualine, gitsigns column, indent guides, modes cursor color.
- All existing keymaps continue to work the same way: `<leader>ff` (Telescope), `<C-a>` (FTerm), `<C-n>` (Yazi), `<C-b>` (Aerial), `<leader>od` (Overlook peek), and others.
- LSP servers (gopls, lua_ls, yamlls, helm_ls, rust-analyzer) attach correctly when their respective filetypes are opened.

## Out of Scope

- The "freeze when opening Rust projects" issue (separate brainstorm).
- Changes to formatters / linters (none-ls source list).
- Adding new features.
- Core option changes such as `vim.cmd.syntax("enable")` removal, treesitter `additional_vim_regex_highlighting`, or `vim.opt.clipboard` deferral. These belong to a follow-up phase if Phase A's reduction is insufficient.

## Approach

### Lazy-loading strategy

lazy.nvim supports several trigger types. We use them as follows:

| Trigger | When to load | Examples |
|---|---|---|
| `event = "InsertEnter"` | First time entering insert mode | `cmp`, `autopairs` (existing), `lualine` (existing) |
| `event = "BufReadPre"` / `"BufNewFile"` | A file buffer is opened | `gitsigns`, `mason-lspconfig`, `treesitter` (existing) |
| `ft = { "<lang>" }` | A specific filetype is detected | `vim-helm`, the three vim-go plugins, `render-markdown` |
| `cmd = { ... }` / `keys = { ... }` | A command runs or a key is pressed | `telescope`, `claude-code`, `aerial` (existing) |
| `lazy = true` | Loaded only as a dependency of another plugin | `nvim-web-devicons`, `plenary` |

### `init.lua` change

Add `vim.loader.enable()` as the very first line:

```lua
vim.loader.enable()  -- Lua bytecode cache (Neovim 0.9+)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- existing logic continues unchanged
require("init")
```

`vim.loader.enable()` activates Neovim's built-in Lua module bytecode cache (under `~/.cache/nvim/luac/`). It speeds up `require()` calls on subsequent launches with no behavioral side effects.

### Plugin loader

`nvim/lua/plugins/init.lua` (the category-based loader) is left unchanged. The `pcall` swallowing pattern is unrelated to startup performance and modifying it falls outside the surgical-change principle for this work.

## Per-plugin Changes

| File | Plugin | Current | After |
|---|---|---|---|
| `editor/telescope.lua` | telescope.nvim | eager | `cmd = "Telescope"` plus existing keymaps moved into a `keys = { ... }` spec |
| `editor/claude-code.lua` | claude-code.nvim | eager | `cmd` / `keys` (the actual command name will be confirmed against the plugin's API during implementation) |
| `editor/treesitter.lua` | nvim-treesitter | event-based (existing) | Drop `playground` from `dependencies`; set `sync_install = false` |
| `lsp/cmp.lua` | nvim-cmp | eager | `event = { "InsertEnter", "CmdlineEnter" }` |
| `lsp/servers.lua` | mason-lspconfig | eager | `event = { "BufReadPre", "BufNewFile" }` |
| `ui/gitsigns.lua` | gitsigns.nvim | eager | `event = { "BufReadPre", "BufNewFile" }` |
| `ui/devicons.lua` | nvim-web-devicons | eager | `lazy = true` (loaded only via dependents: dashboard removed, lualine, aerial) |
| `ui/modes.lua` | modes.nvim | eager | `event = "VeryLazy"` |
| `ui/render-markdown.lua` | render-markdown.nvim | eager | `ft = { "markdown" }` |
| `editor/focus.lua` | focus.nvim | eager | `event = "VeryLazy"` |
| `lang/go.lua` | vim-goimports / vim-goaddtags / vim-go-coverage | eager | Each: `ft = "go"` |
| `lang/rust.lua` (rust.vim) | rust.vim | eager | `ft = "rust"` |
| `lang/rust.lua` (rustaceanvim) | rustaceanvim | `lazy = false` | **Unchanged** — kept eager. `rustaceanvim`'s recommended setup registers the filetype hook from `init`, and `ft = "rust"` is known to break the first attach of `rust-analyzer` |
| `lang/helm.lua` | vim-helm | eager | `ft = "helm"` |

### Plugins already configured for lazy loading (no change)

`tokyonight` (`lazy = false, priority = 1000` — required for colorscheme), `lualine`, `indent-blankline`, `comment`, `autopairs`, `format` (mason-null-ls), `colorizer`, `fterm`, `yazi`, `aerial`, `overlook`, `vim-startuptime`, `mason`, `crates.nvim` (already `event = "BufRead Cargo.toml"`).

### Plugin removals

- **`dashboard-nvim`**: Remove `"dashboard"` from the `ui` category in `nvim/lua/plugins/init.lua` and delete `nvim/lua/plugins/ui/dashboard.lua`.
- **`nvim-treesitter/playground`**: Remove from `dependencies` in `nvim/lua/plugins/editor/treesitter.lua`. Replaced at runtime by Neovim's built-in `:Inspect` / `:InspectTree`.
- `lazy-lock.json` will be regenerated by lazy.nvim on next launch and committed.

## Verification

### Baseline measurement (before change)

```bash
for i in 1 2 3 4 5; do
  nvim --headless --startuptime /tmp/startup-before-$i.log +qa
done
for f in /tmp/startup-before-*.log; do
  tail -1 "$f" | awk '{print $1}'
done
```

### After-change measurement

Same procedure, writing to `/tmp/startup-after-*.log`. Compare the average totals.

### Manual functional checks (one pass each)

1. Plain `nvim` launch — tokyonight-storm colorscheme is applied.
2. Open a `.go` file — gopls attaches, treesitter highlight is on, gitsigns column is shown, indent-blankline guides render.
3. Open a `.rs` file — `rustaceanvim` boots and `rust-analyzer` attaches. (The "freeze" is out of scope; only attachment is verified here.)
4. Open a `.lua` file — `lua_ls` attaches, `cmp` activates on insert.
5. `<leader>ff` — Telescope opens.
6. `<C-n>` — Yazi opens.
7. `<C-a>` — FTerm toggles.
8. `<C-b>` — Aerial toggles.
9. `<leader>od` — Overlook peeks the definition.
10. `:Mason` — Mason UI opens.
11. `:checkhealth lazy` — no errors.
12. `:Lazy` — every plugin's loaded / not-loaded state matches the spec.

### Rollback

`git revert` the change commit, or remove the offending lines manually. The `vim.loader.enable()` bytecode cache lives in `~/.cache/nvim/luac/`; if anything misbehaves there, `rm -rf ~/.cache/nvim/luac/` clears it.

## Measurements

Methodology: 5 runs of `nvim --headless --startuptime <log> +qa`, totals taken from the `--- NVIM STARTED ---` line.

| Run | Before (ms) | After (ms) |
|-----|-------------|-------------|
| 1   | 55.101      | 15.730      |
| 2   | 51.306      | 17.748      |
| 3   | 52.611      | 16.105      |
| 4   | 55.410      | 14.346      |
| 5   | 52.186      | 13.847      |
| **avg** | **53.32** | **15.56**  |

**Reduction: 70.8%** (from 53.32 ms to 15.56 ms). Target was ≥30%; comfortably exceeded.
