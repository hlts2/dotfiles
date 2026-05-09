# Neovim LSP Tooling Dependencies

This document describes how the current Neovim LSP, formatter, linter, Mason, and completion plugins fit together.

## Entry Points

- `nvim/lua/plugins/init.lua` loads plugin specs by category.
- LSP-related specs live under `nvim/lua/plugins/lsp/`.
- Language-specific overrides live under `nvim/lua/plugins/lang/`.

## Dependency Map

```text
lazy.nvim
└─ plugins/init.lua
   └─ lsp category
      ├─ mason.lua
      │  └─ williamboman/mason.nvim
      │
      ├─ tool-installer.lua
      │  ├─ WhoIsSethDaniel/mason-tool-installer.nvim
      │  └─ williamboman/mason.nvim
      │
      ├─ servers.lua
      │  ├─ williamboman/mason-lspconfig.nvim
      │  ├─ williamboman/mason.nvim
      │  ├─ neovim/nvim-lspconfig
      │  └─ hrsh7th/cmp-nvim-lsp
      │
      ├─ cmp.lua
      │  ├─ hrsh7th/nvim-cmp
      │  ├─ hrsh7th/cmp-nvim-lsp
      │  ├─ hrsh7th/cmp-nvim-lsp-signature-help
      │  ├─ hrsh7th/cmp-buffer
      │  ├─ hrsh7th/cmp-path
      │  ├─ hrsh7th/cmp-cmdline
      │  ├─ hrsh7th/cmp-calc
      │  ├─ hrsh7th/cmp-nvim-lua
      │  ├─ hrsh7th/vim-vsnip
      │  ├─ hrsh7th/cmp-vsnip
      │  ├─ ray-x/cmp-treesitter
      │  └─ saecki/crates.nvim
      │
      └─ format.lua
         ├─ jay-babu/mason-null-ls.nvim
         ├─ williamboman/mason.nvim
         └─ nvimtools/none-ls.nvim
```

Rust is handled separately:

```text
lang/rust.lua
├─ rust-lang/rust.vim
└─ mrcjkb/rustaceanvim
   └─ rust-analyzer / clippy / rustfmt from rustup-selected toolchain
```

## Responsibilities

| Area | Plugin / file | Responsibility |
|---|---|---|
| Mason UI and package registry | `mason.lua` / `williamboman/mason.nvim` | Provides the `:Mason` UI and package installation backend. |
| Mason package list | `tool-installer.lua` / `mason-tool-installer.nvim` | Single source of truth for tools installed by Mason. |
| LSP server wiring | `servers.lua` / `mason-lspconfig.nvim` | Connects Mason-installed LSP servers to Neovim LSP. Does not own `ensure_installed`. |
| LSP behavior | `servers.lua` / `nvim-lspconfig` and `vim.lsp.config` | Defines server-specific settings, filetypes, root markers, keymaps, and capabilities. |
| Completion engine | `cmp.lua` / `nvim-cmp` | Provides completion UI and source configuration. |
| LSP completion capabilities | `cmp.lua` and `servers.lua` / `cmp-nvim-lsp` | Extends LSP client capabilities so servers can provide richer completion items. |
| External linters/formatters | `format.lua` / `none-ls.nvim` | Exposes non-LSP tools as LSP diagnostics/formatting sources. |
| Mason to none-ls bridge | `format.lua` / `mason-null-ls.nvim` | Connects Mason-installed formatter/linter packages to none-ls. Does not own `ensure_installed`. |
| Rust LSP and tools | `lang/rust.lua` / `rustaceanvim` | Uses rustup-selected Rust tooling instead of Mason-managed `rust-analyzer`. |

## Tool Ownership

Mason-managed tools belong in:

- `nvim/lua/plugins/lsp/tool-installer.lua`

Examples:

- LSP servers: `gopls`, `lua-language-server`, `helm-ls`, `nil`, `vtsls`, `yaml-language-server`
- Linters: `actionlint`, `hadolint`, `protolint`, `sqlfluff`, `tfsec`
- Formatters: `black`, `buf`, `gofumpt`, `goimports`, `nixfmt`, `sql-formatter`, `stylua`

Tools managed outside Mason should be documented near the integration that consumes them.

Examples:

- Rust tools: `rust-analyzer`, `clippy`, and `rustfmt` are expected from `rustup`.
- Terraform tools: `terraform_fmt` and `terraform_validate` expect the `terraform` CLI.
- Some none-ls sources may come from OS packages, cargo installs, or project-local toolchains.

## Load-Time Notes

- `mason.nvim` is command-loaded for Mason commands such as `:Mason`.
- `mason-tool-installer.nvim` runs on `VeryLazy`, then installs missing Mason-managed tools after startup.
- `mason-lspconfig.nvim` runs on `BufReadPre` / `BufNewFile` and enables configured LSP servers.
- `nvim-cmp` runs on `InsertEnter` / `CmdlineEnter`.
- `mason-null-ls.nvim` and `none-ls.nvim` run on `BufReadPre` / `BufNewFile`.
- `rustaceanvim` is not lazy-loaded, because Rust LSP behavior is managed separately from Mason.

## Change Guide

Add a new Mason-installed LSP server:

1. Add the Mason package name to `tool-installer.lua`.
2. Add or adjust server settings in `servers.lua` if defaults are not enough.
3. Do not add `ensure_installed` to `mason-lspconfig`.

Add a new Mason-installed formatter or linter:

1. Add the Mason package name to `tool-installer.lua`.
2. Add the matching none-ls source to `format.lua`.
3. Do not add `ensure_installed` to `mason-null-ls`.

Add a tool managed by OS/cargo/rustup:

1. Do not add it to `tool-installer.lua`.
2. Add a comment near the consumer that states how the tool is installed.
3. Make sure the executable is available on `$PATH` in the target environment.

Change completion behavior:

1. Update `cmp.lua`.
2. If LSP completion capabilities change, verify `servers.lua` still passes `cmp_nvim_lsp.default_capabilities(...)` into `vim.lsp.config("*", ...)`.

Change Rust behavior:

1. Update `lang/rust.lua`.
2. Keep Rust tool installation tied to `rustup` unless there is a deliberate reason to move it into Mason.

