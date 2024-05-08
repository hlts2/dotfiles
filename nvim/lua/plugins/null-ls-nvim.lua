local M = {}

function M.setup()
	local null_ls = require("null-ls")
	local diagnostics = null_ls.builtins.diagnostics
	local formatting = null_ls.builtins.formatting

	null_ls.setup({
		-- https://github.com/nvimtools/none-ls.nvim/blob/main/lua/null-ls/builtins/_meta/diagnostics.lua
		sources = {
			-- yaml
			diagnostics.actionlint,
			-- -- dockerfile
			diagnostics.hadolint,
			-- -- proto
			diagnostics.protolint,
			-- -- yaml, json
			-- diagnostics.spectral,
			-- -- sql
			diagnostics.sqlfluff,
			-- -- nix
			diagnostics.deadnix,
			-- -- tf
			diagnostics.terraform_validate,
			diagnostics.tfsec,
			-- -- zsh
			diagnostics.zsh,

			-- python
			formatting.black,
			-- proto
			formatting.buf,
			-- rust
			formatting.dxfmt,
			-- go
			formatting.gofumpt,
			formatting.goimports,
			-- nix
			formatting.nixfmt,
			-- js, ts, json ...etc
			-- formatting.prettier,
			-- sql
			formatting.sql_formatter,
			-- luq
			formatting.stylua,
			-- tf
			formatting.terraform_fmt,
		},
		on_attach = function(current_client, bufnr)
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			if current_client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						-- vim.lsp.buf.format({
						-- 	filter = function(client)
						-- 		--  only use null-ls for formatting instead of lsp server
						-- 		return client.name == "null-ls"
						-- 	end,
						-- 	bufnr = bufnr,
						-- })
					end,
				})
			end
		end,
	})
end

return M
