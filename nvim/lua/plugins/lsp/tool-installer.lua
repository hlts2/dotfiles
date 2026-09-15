-- mason-tool-installer.nvim: Unified ensure_installed for Mason packages.
-- This file owns only tools installed through Mason.
--
-- Boundary:
-- - Mason-managed tools belong in ensure_installed below.
-- - OS package manager, cargo, rustup, or project-local tools should not be
--   listed here; document those near the integration that consumes them.
--
-- Installing a package here does not enable anything on its own: servers are
-- enabled by the vim.lsp.enable() list in lsp/servers.lua, and conform.nvim and
-- nvim-lint pick the rest up from Mason's bin directory on PATH.
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "williamboman/mason.nvim" },
	event = "VeryLazy",
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- LSP servers
				"basedpyright",
				-- biome and eslint-lsp are fallbacks: both the LSP and conform
				-- prefer the project's own node_modules/.bin copy when present.
				"biome",
				"eslint-lsp",
				"gopls",
				"graphql-language-service-cli",
				"lua-language-server",
				"helm-ls",
				"nil",
				-- ruff is the language server, the linter and the formatter for
				-- python all at once, so it is only listed here.
				"ruff",
				"vtsls",
				"yaml-language-server",
				"terraform-ls",
				{ "zls", version = "0.16.0" },

				-- Diagnostics (linters)
				"actionlint",
				"hadolint",
				"protolint",
				"sqlfluff",
				"tfsec",

				-- Formatters
				"buf",
				"gofumpt",
				"goimports",
				"nixfmt",
				"sql-formatter",
				"stylua",
			},
			run_on_start = true,
			auto_update = false,
			start_delay = 3000,
		})
	end,
}
