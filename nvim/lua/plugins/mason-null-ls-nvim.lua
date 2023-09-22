local M = {}

M.default_options = function()
	return {
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
			-- "taplo",
			"yamlfmt",
			"zsh",
		},
		automatic_installation = true,
	}
end

return M
