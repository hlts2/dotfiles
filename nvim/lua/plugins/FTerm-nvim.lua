local M = {}

M.default_options = function()
	return {
		border = "double",
		dimensions = {
			height = 0.9,
			width = 0.9,
		},
	}
end

vim.keymap.set("n", "<C-l>", '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set("t", "<C-l>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

return M
