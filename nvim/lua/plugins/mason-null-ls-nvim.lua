local M = {}

function M.setup()
	require("mason-null-ls").setup({
		-- NOTE: https://github.com/jay-babu/mason-null-ls.nvim/blob/v2.1.0/lua/mason-null-ls/mappings/filetype.lua
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
			-- "taplo",
		},
		automatic_installation = true,
		handlers = {},
	})
end

return M
