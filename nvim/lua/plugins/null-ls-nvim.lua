local M = {}

M.setup = function()
	local null_ls = require("null-ls")
	local diagnostics = null_ls.builtins.diagnostics
	local formatting = null_ls.builtins.formatting

	null_ls.setup({
		sources = {
			diagnostics.actionlint,
			diagnostics.hadolint,
			-- diagnostics.taplo,
			diagnostics.zsh,
			formatting.beautysh,
			formatting.black,
			formatting.clang_format,
			formatting.gofumpt,
			formatting.goimports,
			formatting.prettier,
			formatting.stylua,
			formatting.taplo,
			formatting.yamlfmt,
		},
		on_attach = function(current_client, bufnr)
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			if current_client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							filter = function(client)
								--  only use null-ls for formatting instead of lsp server
								return client.name == "null-ls"
							end,
							bufnr = bufnr,
						})
					end,
				})
			end
		end,
	})
end

return M
