-- mason-tool-installer.nvim: Unified ensure_installed for Mason packages
-- Owns the single source of truth for LSPs, linters, and formatters that
-- should be installed via Mason. mason-lspconfig / mason-null-ls remain
-- responsible only for wiring installed packages into nvim-lspconfig /
-- none-ls respectively.
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "williamboman/mason.nvim" },
	event = "VeryLazy",
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- LSP servers
				"gopls",
				"graphql-language-service-cli",
				"lua-language-server",
				"helm-ls",
				"nil",
				"vtsls",
				"yaml-language-server",
				{ 'zls', version = '0.16.0' },

				-- Diagnostics (linters)
				"actionlint",
				"hadolint",
				"protolint",
				"sqlfluff",
				"tfsec",

				-- Formatters
				"black",
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
