-- Formatter/Linter configuration
-- none-ls: Integrates external tools using Neovim's built-in LSP
-- mason-null-ls: Connects tools installed via mason to none-ls
return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		{
			"nvimtools/none-ls.nvim",
			config = function()
				local null_ls = require("null-ls")
				local diagnostics = null_ls.builtins.diagnostics
				local formatting = null_ls.builtins.formatting

				null_ls.setup({
					sources = {
						-- Diagnostics (Linters)
						diagnostics.actionlint, -- yaml (GitHub Actions)
						diagnostics.hadolint, -- dockerfile
						diagnostics.protolint, -- proto
						diagnostics.sqlfluff, -- sql
						diagnostics.deadnix, -- nix
						diagnostics.terraform_validate, -- tf
						diagnostics.tfsec, -- tf
						diagnostics.zsh, -- zsh

						-- Formatting (Formatters)
						formatting.black, -- python
						formatting.buf, -- proto
						formatting.dxfmt, -- rust
						formatting.gofumpt, -- go
						formatting.goimports, -- go
						formatting.nixfmt, -- nix
						formatting.sql_formatter, -- sql
						formatting.stylua, -- lua
						formatting.terraform_fmt, -- tf
					},
					on_attach = function(current_client, bufnr)
						local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
						if current_client.supports_method("textDocument/formatting") then
							vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
							vim.api.nvim_create_autocmd("BufWritePre", {
								group = augroup,
								buffer = bufnr,
								callback = function() end,
							})
						end
					end,
				})
			end,
		},
	},
	config = function()
		require("mason-null-ls").setup({
			-- Only tools that correspond to sources (installable via mason)
			ensure_installed = {
				-- Diagnostics
				"actionlint",
				"hadolint",
				"protolint",
				"sqlfluff",
				"tfsec",
				-- Formatting
				"black",
				"buf",
				"gofumpt",
				"goimports",
				"nixfmt",
				"sql-formatter",
				"stylua",
				-- "deadnix" -- Install via 'cargo install deadnix'
			},
			automatic_installation = false,
			handlers = {},
		})
	end,
}
