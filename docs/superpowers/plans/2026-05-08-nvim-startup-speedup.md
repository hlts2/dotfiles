# Neovim Startup Speedup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Shorten Neovim's cold-start time by enabling the Lua bytecode cache, removing two unused plugins (dashboard-nvim, treesitter playground), and converting eagerly-loaded plugins to lazy loading via `event` / `cmd` / `ft` / `keys`.

**Architecture:** Plugin specs in `nvim/lua/plugins/**/*.lua` are managed by lazy.nvim. lazy.nvim defers a plugin's load until a trigger fires (event, command, filetype, key, or dependent plugin). The change is purely about adding the right trigger to each plugin's spec; no code is restructured. `init.lua` gets one new line (`vim.loader.enable()`) at the top.

**Tech Stack:** Neovim 0.11.7, lazy.nvim, Lua. No new dependencies.

**Spec:** [`docs/superpowers/specs/2026-05-08-nvim-startup-speedup-design.md`](../specs/2026-05-08-nvim-startup-speedup-design.md)

**Commit conventions:** Existing repo style (`feat:`, `fix:`, `docs:`). Use `--signoff` (the user's preference; no GPG flag needed — let the configured key sign normally; if pinentry is dismissed, retry).

---

## File Structure

**Modified:**
- `nvim/init.lua` — add `vim.loader.enable()` as the first line.
- `nvim/lua/plugins/init.lua` — remove `"dashboard"` from the `ui` category.
- `nvim/lua/plugins/editor/treesitter.lua` — drop `playground` from `dependencies`; set `sync_install = false`.
- `nvim/lua/plugins/editor/telescope.lua` — add `cmd = "Telescope"` and move keymaps into `keys = { ... }`.
- `nvim/lua/plugins/editor/claude-code.lua` — add `cmd = "ClaudeCode"`.
- `nvim/lua/plugins/lsp/cmp.lua` — add `event = { "InsertEnter", "CmdlineEnter" }`.
- `nvim/lua/plugins/lsp/servers.lua` — add `event = { "BufReadPre", "BufNewFile" }`.
- `nvim/lua/plugins/ui/gitsigns.lua` — add `event = { "BufReadPre", "BufNewFile" }`.
- `nvim/lua/plugins/ui/devicons.lua` — add `lazy = true`.
- `nvim/lua/plugins/ui/modes.lua` — add `event = "VeryLazy"`.
- `nvim/lua/plugins/ui/render-markdown.lua` — add `ft = { "markdown" }`.
- `nvim/lua/plugins/editor/focus.lua` — add `event = "VeryLazy"`.
- `nvim/lua/plugins/lang/go.lua` — add `ft = "go"` to each of the three plugins.
- `nvim/lua/plugins/lang/rust.lua` — add `ft = "rust"` to `rust.vim` only (`rustaceanvim` stays `lazy = false`).
- `nvim/lua/plugins/lang/helm.lua` — add `ft = "helm"`.

**Deleted:**
- `nvim/lua/plugins/ui/dashboard.lua`

**Auto-updated:**
- `nvim/lazy-lock.json` — lazy.nvim regenerates on next launch after plugins change. Commit at the end.

---

## Task 1: Capture baseline startup time

**Files:**
- Create: `/tmp/startup-before-{1..5}.log` (transient)
- Record: append a "Baseline" line to this plan's bottom under "Measurements" (manual note)

- [ ] **Step 1: Run baseline 5 times**

```bash
for i in 1 2 3 4 5; do
  nvim --headless --startuptime "/tmp/startup-before-$i.log" +qa
done
```

Expected: 5 log files, each ending with a final line whose first column is the total ms.

- [ ] **Step 2: Record the totals**

```bash
for f in /tmp/startup-before-*.log; do
  tail -1 "$f" | awk '{print $1}'
done
```

Expected: 5 numbers (e.g., `123.456`). Eyeball the average and write it down — this is the baseline. No commit.

---

## Task 2: Add `vim.loader.enable()` to `init.lua`

**Files:**
- Modify: `nvim/init.lua` (add line at top)

- [ ] **Step 1: Edit `nvim/init.lua`**

Insert `vim.loader.enable()` as the new first line. The full file becomes:

```lua
vim.loader.enable()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
	print("lazy.nvim was installed: " .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

require("init")
```

- [ ] **Step 2: Verify nvim still boots cleanly**

```bash
nvim --headless +qa
```

Expected: exit code 0, no error output.

- [ ] **Step 3: Commit**

```bash
git add nvim/init.lua
git commit --signoff -m "feat(nvim): enable vim.loader bytecode cache"
```

---

## Task 3: Remove `dashboard-nvim`

**Files:**
- Modify: `nvim/lua/plugins/init.lua` (drop `"dashboard"` from ui category)
- Delete: `nvim/lua/plugins/ui/dashboard.lua`

- [ ] **Step 1: Remove `"dashboard"` from the `ui` category**

In `nvim/lua/plugins/init.lua`, the `ui` block currently reads:

```lua
		ui = {
			"colorscheme",
			"lualine",
			"indent-blankline",
			"modes",
			"devicons",
			"dashboard",
			"gitsigns",
			"render-markdown",
		},
```

Change it to:

```lua
		ui = {
			"colorscheme",
			"lualine",
			"indent-blankline",
			"modes",
			"devicons",
			"gitsigns",
			"render-markdown",
		},
```

- [ ] **Step 2: Delete the dashboard plugin file**

```bash
rm nvim/lua/plugins/ui/dashboard.lua
```

- [ ] **Step 3: Verify nvim still boots cleanly**

```bash
nvim --headless +qa
```

Expected: exit code 0, no error referencing "dashboard".

- [ ] **Step 4: Commit**

```bash
git add nvim/lua/plugins/init.lua nvim/lua/plugins/ui/dashboard.lua
git commit --signoff -m "feat(nvim): drop dashboard-nvim"
```

---

## Task 4: Trim `nvim-treesitter` (drop playground, disable sync_install)

**Files:**
- Modify: `nvim/lua/plugins/editor/treesitter.lua`

- [ ] **Step 1: Remove `playground` and flip `sync_install`**

Replace the contents of `nvim/lua/plugins/editor/treesitter.lua` with:

```lua
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "master",
	commit = "cf12346a3414fa1b06af75c79faebe7f76df080a",
	event = {
		"BufReadPost",
		"BufNewFile",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"cmake",
				"comment",
				"cpp",
				"cue",
				"dart",
				"diff",
				"dockerfile",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"graphql",
				"html",
				"http",
				"java",
				"javascript",
				"jsdoc",
				"json",
				"json5",
				"llvm",
				"lua",
				"luadoc",
				"make",
				"markdown",
				"ron",
				"rust",
				"sql",
				"terraform",
				"toml",
				"vim",
				"yaml",
				"zig",
			},
			ignore_install = {},
			sync_install = false,
			auto_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
			indent = {
				enable = true,
			},
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = nil,
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			matchup = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
		})
	end,
}
```

The only changes from the current file are:
- The `dependencies = { "nvim-treesitter/playground" }` block is gone.
- `sync_install = true` → `sync_install = false`.

- [ ] **Step 2: Open a real file to trigger treesitter, then quit**

```bash
nvim --headless README.md +qa
```

Expected: exit code 0, no error output. (Existing parsers stay installed; `sync_install = false` only affects future missing-parser installs.)

- [ ] **Step 3: Commit**

```bash
git add nvim/lua/plugins/editor/treesitter.lua
git commit --signoff -m "feat(nvim): drop treesitter playground dep, disable sync_install"
```

---

## Task 5: Lazy-load `telescope.nvim`

**Files:**
- Modify: `nvim/lua/plugins/editor/telescope.lua`

- [ ] **Step 1: Replace the file with a lazy-loaded spec**

Replace the contents of `nvim/lua/plugins/editor/telescope.lua` with:

```lua
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.4",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
		{ "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
		{ "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
		{ "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help tags" },
		{ "<leader>fd", function() require("telescope.builtin").lsp_definitions() end, desc = "Find definition" },
		{ "<leader>fi", function() require("telescope.builtin").lsp_implementations() end, desc = "Find implementation" },
		{ "<leader>fr", function() require("telescope.builtin").lsp_references() end, desc = "Find reference" },
		{ "<leader>ft", function() require("telescope.builtin").lsp_type_definitions() end, desc = "Find type definition" },
		{ "<leader>fs", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Find symbols (file)" },
		{ "<leader>fS", function() require("telescope.builtin").lsp_workspace_symbols() end, desc = "Find symbols (workspace)" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
			pickers = {
				find_files = {
					-- theme = "dropdown",
				},
			},
		})
	end,
}
```

Notes:
- `cmd = "Telescope"` triggers load on `:Telescope <subcmd>`.
- `keys = { ... }` triggers load on first key press; the `function()` form defers `require("telescope.builtin")` until after telescope itself is loaded.
- All 10 keymaps are preserved (4 builtin pickers + 6 LSP pickers).
- The `vim.keymap.set(...)` block in `config` is removed because `keys = { ... }` now owns those keymaps.

- [ ] **Step 2: Verify the spec loads cleanly**

```bash
nvim --headless +qa
```

Expected: exit code 0, no error.

- [ ] **Step 3: Verify keys still work (interactive — quick smoke test)**

Open nvim, press `<leader>ff` (Space-f-f), confirm Telescope opens, press `<Esc>` to close, `:q` to quit. (Skip if running fully headless; record as a manual check before final merge.)

- [ ] **Step 4: Commit**

```bash
git add nvim/lua/plugins/editor/telescope.lua
git commit --signoff -m "feat(nvim): lazy-load telescope on cmd/keys"
```

---

## Task 6: Lazy-load `claude-code.nvim`

**Files:**
- Modify: `nvim/lua/plugins/editor/claude-code.lua`

- [ ] **Step 1: Confirm the plugin's command name**

```bash
grep -rE "command!|nvim_create_user_command" ~/.local/share/nvim/lazy/claude-code.nvim/lua/ 2>/dev/null | head -20
```

Expected: lines mentioning `ClaudeCode` (the plugin's primary user command). If a different command name appears, use that name in the next step.

- [ ] **Step 2: Replace the file with a lazy-loaded spec**

Replace the contents of `nvim/lua/plugins/editor/claude-code.lua` with:

```lua
return {
	"greggh/claude-code.nvim",
	cmd = "ClaudeCode",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("claude-code").setup()
	end,
}
```

(If Step 1 shows a different command name, swap `"ClaudeCode"` for the actual one. If the plugin exposes multiple commands, list them all: `cmd = { "ClaudeCode", "ClaudeCodeOther" }`.)

- [ ] **Step 3: Verify the spec loads cleanly**

```bash
nvim --headless +qa
```

Expected: exit code 0.

- [ ] **Step 4: Commit**

```bash
git add nvim/lua/plugins/editor/claude-code.lua
git commit --signoff -m "feat(nvim): lazy-load claude-code on cmd"
```

---

## Task 7: Lazy-load `nvim-cmp`

**Files:**
- Modify: `nvim/lua/plugins/lsp/cmp.lua`

- [ ] **Step 1: Add `event` to the top-level spec**

In `nvim/lua/plugins/lsp/cmp.lua`, modify the very top of the returned table from:

```lua
return {
	"hrsh7th/nvim-cmp",
	dependencies = {
```

to:

```lua
return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
```

`InsertEnter` covers buffer completion. `CmdlineEnter` covers the `:` and `/` cmdline completion that the existing `cmp.setup.cmdline(...)` blocks configure.

The rest of the file (dependencies, config, cmdline setup) is unchanged.

- [ ] **Step 2: Verify the spec loads cleanly**

```bash
nvim --headless +qa
```

Expected: exit code 0.

- [ ] **Step 3: Commit**

```bash
git add nvim/lua/plugins/lsp/cmp.lua
git commit --signoff -m "feat(nvim): lazy-load nvim-cmp on InsertEnter/CmdlineEnter"
```

---

## Task 8: Lazy-load `mason-lspconfig.nvim` (servers.lua)

**Files:**
- Modify: `nvim/lua/plugins/lsp/servers.lua`

- [ ] **Step 1: Add `event` to the top-level spec**

In `nvim/lua/plugins/lsp/servers.lua`, modify the top of the returned table from:

```lua
return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
```

to:

```lua
return {
	"williamboman/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
```

Everything else (dependencies, all `vim.lsp.config(...)` blocks, the `LspAttach` autocmd, keymaps) stays the same.

- [ ] **Step 2: Verify nvim boots and a buffer triggers LSP attach**

```bash
nvim --headless README.md +qa
```

Expected: exit code 0. (Opening a file triggers `BufReadPre`, which triggers mason-lspconfig load. README.md doesn't have an LSP server, so attach won't fire — but the spec must load without error.)

- [ ] **Step 3: Commit**

```bash
git add nvim/lua/plugins/lsp/servers.lua
git commit --signoff -m "feat(nvim): lazy-load mason-lspconfig on buffer read"
```

---

## Task 9: Lazy-load `gitsigns.nvim`

**Files:**
- Modify: `nvim/lua/plugins/ui/gitsigns.lua`

- [ ] **Step 1: Replace the file**

Replace the contents of `nvim/lua/plugins/ui/gitsigns.lua` with:

```lua
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = true,
}
```

- [ ] **Step 2: Verify the spec loads cleanly**

```bash
nvim --headless +qa
```

Expected: exit code 0.

- [ ] **Step 3: Commit**

```bash
git add nvim/lua/plugins/ui/gitsigns.lua
git commit --signoff -m "feat(nvim): lazy-load gitsigns on buffer read"
```

---

## Task 10: Lazy-load `nvim-web-devicons`

**Files:**
- Modify: `nvim/lua/plugins/ui/devicons.lua`

- [ ] **Step 1: Add `lazy = true` to the spec**

Replace the contents of `nvim/lua/plugins/ui/devicons.lua` with:

```lua
return {
	"nvim-tree/nvim-web-devicons",
	lazy = true,
	config = function()
		require("nvim-web-devicons").setup({
			override = {
				zsh = {
					icon = "",
					color = "#428850",
					cterm_color = "65",
					name = "Zsh",
				},
			},
			color_icons = true,
			default = true,
			strict = true,
			override_by_filename = {
				[".gitignore"] = {
					icon = "",
					color = "#f1502f",
					name = "Gitignore",
				},
			},
			override_by_extension = {
				["log"] = {
					icon = "",
					color = "#81e043",
					name = "Log",
				},
			},
		})
	end,
}
```

`lazy = true` keeps devicons unloaded until something depends on it. lualine and aerial both list it under `dependencies`, so it loads exactly when those plugins load.

- [ ] **Step 2: Verify the spec loads cleanly**

```bash
nvim --headless +qa
```

Expected: exit code 0.

- [ ] **Step 3: Commit**

```bash
git add nvim/lua/plugins/ui/devicons.lua
git commit --signoff -m "feat(nvim): mark devicons as lazy (loaded by dependents)"
```

---

## Task 11: Lazy-load `modes.nvim`

**Files:**
- Modify: `nvim/lua/plugins/ui/modes.lua`

- [ ] **Step 1: Add `event = "VeryLazy"`**

Replace the contents of `nvim/lua/plugins/ui/modes.lua` with:

```lua
return {
	"mvllow/modes.nvim",
	tag = "v0.2.0",
	event = "VeryLazy",
	config = function()
		require("modes").setup({
			colors = {
				copy = "#f5c359",
				delete = "#c75c6a",
				insert = "#78ccc5",
				visual = "#9745be",
			},
			ignore_filetypes = { "NvimTreeToggle", "TelescopePrompt" },
		})
	end,
}
```

- [ ] **Step 2: Verify the spec loads cleanly**

```bash
nvim --headless +qa
```

Expected: exit code 0.

- [ ] **Step 3: Commit**

```bash
git add nvim/lua/plugins/ui/modes.lua
git commit --signoff -m "feat(nvim): lazy-load modes.nvim on VeryLazy"
```

---

## Task 12: Lazy-load `render-markdown.nvim`

**Files:**
- Modify: `nvim/lua/plugins/ui/render-markdown.lua`

- [ ] **Step 1: Add `ft = { "markdown" }`**

Replace the contents of `nvim/lua/plugins/ui/render-markdown.lua` with:

```lua
return {
	'MeanderingProgrammer/render-markdown.nvim',
	ft = { "markdown" },
	dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
	opts = {},
}
```

- [ ] **Step 2: Verify the spec loads cleanly**

```bash
nvim --headless +qa
```

Expected: exit code 0.

- [ ] **Step 3: Commit**

```bash
git add nvim/lua/plugins/ui/render-markdown.lua
git commit --signoff -m "feat(nvim): lazy-load render-markdown on markdown ft"
```

---

## Task 13: Lazy-load `focus.nvim`

**Files:**
- Modify: `nvim/lua/plugins/editor/focus.lua`

- [ ] **Step 1: Add `event = "VeryLazy"`**

Replace the contents of `nvim/lua/plugins/editor/focus.lua` with:

```lua
return {
	"nvim-focus/focus.nvim",
	tag = "v1.0.0",
	event = "VeryLazy",
	config = function()
		require("focus").setup({
			enable = true,
		})
	end,
}
```

- [ ] **Step 2: Verify the spec loads cleanly**

```bash
nvim --headless +qa
```

Expected: exit code 0.

- [ ] **Step 3: Commit**

```bash
git add nvim/lua/plugins/editor/focus.lua
git commit --signoff -m "feat(nvim): lazy-load focus.nvim on VeryLazy"
```

---

## Task 14: Lazy-load Go plugins

**Files:**
- Modify: `nvim/lua/plugins/lang/go.lua`

- [ ] **Step 1: Add `ft = "go"` to each plugin in the array**

Replace the contents of `nvim/lua/plugins/lang/go.lua` with:

```lua
return {
	{ "mattn/vim-goimports", ft = "go" },
	{ "mattn/vim-goaddtags", ft = "go" },
	{ "kyoh86/vim-go-coverage", ft = "go" },
}
```

- [ ] **Step 2: Verify the spec loads cleanly**

```bash
nvim --headless +qa
```

Expected: exit code 0.

- [ ] **Step 3: Commit**

```bash
git add nvim/lua/plugins/lang/go.lua
git commit --signoff -m "feat(nvim): lazy-load go plugins on go ft"
```

---

## Task 15: Lazy-load `rust.vim` (rustaceanvim stays eager)

**Files:**
- Modify: `nvim/lua/plugins/lang/rust.lua`

- [ ] **Step 1: Add `ft = "rust"` to `rust.vim` only**

Replace the contents of `nvim/lua/plugins/lang/rust.lua` with:

```lua
return {
	{
		"rust-lang/rust.vim",
		ft = "rust",
		config = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
		init = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = function(_, bufnr)
						vim.keymap.set("n", "<C-space>", function()
							vim.cmd.RustLsp({ "hover", "actions" })
						end, { buffer = bufnr })
						vim.keymap.set("n", "<Leader>a", function()
							vim.cmd.RustLsp("codeAction")
						end, { buffer = bufnr })
					end,
					default_settings = {
						["rust-analyzer"] = {
							imports = { granularity = { group = "module" }, prefix = "self" },
							diagnostics = { enable = true },
							check = { command = "clippy" },
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
						},
					},
				},
			}
		end,
	},
}
```

The only change is `ft = "rust"` added to `rust.vim`. `rustaceanvim` keeps `lazy = false` per the design (its filetype hook must register from `init`).

- [ ] **Step 2: Verify the spec loads cleanly**

```bash
nvim --headless +qa
```

Expected: exit code 0.

- [ ] **Step 3: Commit**

```bash
git add nvim/lua/plugins/lang/rust.lua
git commit --signoff -m "feat(nvim): lazy-load rust.vim on rust ft"
```

---

## Task 16: Lazy-load `vim-helm`

**Files:**
- Modify: `nvim/lua/plugins/lang/helm.lua`

- [ ] **Step 1: Add `ft = "helm"`**

Replace the contents of `nvim/lua/plugins/lang/helm.lua` with:

```lua
return {
	"towolf/vim-helm",
	ft = "helm",
}
```

- [ ] **Step 2: Verify the spec loads cleanly**

```bash
nvim --headless +qa
```

Expected: exit code 0.

- [ ] **Step 3: Commit**

```bash
git add nvim/lua/plugins/lang/helm.lua
git commit --signoff -m "feat(nvim): lazy-load vim-helm on helm ft"
```

---

## Task 17: Measure after, run functional checks, commit lazy-lock

**Files:**
- Possibly modified: `nvim/lazy-lock.json` (lazy.nvim regenerates after the dashboard/playground removals settle)

- [ ] **Step 1: Run after-change baseline 5 times**

```bash
for i in 1 2 3 4 5; do
  nvim --headless --startuptime "/tmp/startup-after-$i.log" +qa
done
for f in /tmp/startup-after-*.log; do
  tail -1 "$f" | awk '{print $1}'
done
```

Expected: 5 numbers. Compare the average against the Task 1 baseline. **Pass condition: ≥30% reduction.** If less, note the gap and discuss before merging — it may indicate a follow-up phase (Approach B from the spec) is warranted.

- [ ] **Step 2: Functional check — plain launch**

```bash
nvim
```

Inside: confirm tokyonight-storm colors are applied (the comment column should be a muted blue-grey). `:q`.

- [ ] **Step 3: Functional check — Go file**

```bash
nvim main.go
```

Use any existing `.go` file (or create one with `package main`). Confirm:
- Treesitter highlight is on (keywords coloured).
- Gitsigns column appears (left of line numbers, even if no signs are pending).
- Indent-blankline guides render.
- `:LspInfo` shows `gopls` attached (after a moment).

`:q`.

- [ ] **Step 4: Functional check — Rust file**

```bash
nvim src/main.rs
```

Confirm `rust-analyzer` attaches (visible via `:LspInfo`). The "freeze" issue is out of scope — do not investigate it here. `:q!`.

- [ ] **Step 5: Functional check — Lua file**

```bash
nvim init.lua
```

Confirm `lua_ls` attaches and entering insert mode triggers cmp suggestions. `:q!`.

- [ ] **Step 6: Functional check — keys & commands**

Open `nvim` and run each:
- `<leader>ff` → Telescope opens, `<Esc>` to close.
- `<C-n>` → Yazi opens, `q` to close.
- `<C-a>` → FTerm toggles, `<C-a>` again to close.
- `<C-b>` → Aerial toggles, `<C-b>` again to close.
- `<leader>od` (in a buffer with code) → Overlook peek; `<leader>oc` to close.
- `:Mason` → Mason UI opens; `q` to close.
- `:checkhealth lazy` → no errors.
- `:Lazy` → review the loaded/not-loaded states match expectations (telescope/cmp/etc. should be "Not loaded" if you haven't triggered them).

`:qa`.

- [ ] **Step 7: Commit `lazy-lock.json` if it changed**

```bash
git status nvim/lazy-lock.json
```

If modified:

```bash
git add nvim/lazy-lock.json
git commit --signoff -m "chore(nvim): refresh lazy-lock after plugin spec changes"
```

If unchanged: skip.

- [ ] **Step 8: Append measurement results to the spec**

Add a "Measurements" section to the bottom of `docs/superpowers/specs/2026-05-08-nvim-startup-speedup-design.md`:

```markdown
## Measurements

- **Before** (5-run avg): `<X.XX>` ms
- **After** (5-run avg): `<Y.YY>` ms
- **Reduction**: `<Z>` % (`(X - Y) / X * 100`)
```

Fill the actual numbers from Step 1 of Task 1 and Step 1 of this task.

```bash
git add docs/superpowers/specs/2026-05-08-nvim-startup-speedup-design.md
git commit --signoff -m "docs: record nvim startup measurements"
```

---

## Rollback

If anything misbehaves at any point:

```bash
# Revert the most recent commit (or several)
git revert HEAD

# Clear the bytecode cache if it seems stuck
rm -rf ~/.cache/nvim/luac/
```
