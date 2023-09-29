local M = {}

function M.keys()
	return { "<C-a>" }
end

function M.setup()
	require("FTerm").setup({
		border = "double",
		dimensions = {
			height = 0.9,
			width = 0.9,
		},
	})
	vim.keymap.set("n", "<C-a>", '<CMD>lua require("FTerm").toggle()<CR>')
	vim.keymap.set("t", "<C-a>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
end

return M
