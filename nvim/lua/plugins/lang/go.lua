return {
	{
		"mattn/vim-goimports",
		ft = "go",
		init = function()
			-- Formatting on save belongs to conform.nvim (see lsp/format.lua);
			-- this plugin stays for :GoImportRun and :GoImport only.
			vim.g.goimports_autoformat = 0
		end,
	},
	{ "mattn/vim-goaddtags", ft = "go" },
	{ "kyoh86/vim-go-coverage", ft = "go" },
}
