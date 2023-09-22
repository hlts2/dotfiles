local M = {}

M.default_options = function()
	return {
		show_end_of_line = true,
	}
end

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

return M
