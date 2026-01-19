-- フォーマッター/リンターの設定
-- none-ls: Neovim内蔵LSPを使って外部ツールを統合
-- mason-null-ls: masonでインストールしたツールをnone-lsに接続
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
						-- Diagnostics (リンター)
						diagnostics.actionlint, -- yaml (GitHub Actions)
						diagnostics.hadolint, -- dockerfile
						diagnostics.protolint, -- proto
						diagnostics.sqlfluff, -- sql
						diagnostics.deadnix, -- nix
						diagnostics.terraform_validate, -- tf
						diagnostics.tfsec, -- tf
						diagnostics.zsh, -- zsh

						-- Formatting (フォーマッター)
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
			ensure_installed = {
				"beautysh",
				"black",
				"clang_format",
				"gofumpt",
				"goimports",
				"hadolint",
				"prettier",
				"rustfmt",
				"stylua",
				"terrafmt",
				"yamlfmt",
				"zsh",
			},
			automatic_installation = true,
			handlers = {},
		})
	end,
}
