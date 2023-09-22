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

vim.keymap.set("n", "<S-o>", '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set("t", "<S-o>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

return M
