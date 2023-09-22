local M = {}

M.default_options = function()
	return {
		colors = {
			copy = "#f5c359",
			delete = "#c75c6a",
			insert = "#78ccc5",
			visual = "#9745be",
		},
		-- ignore_filetypes = { 'NvimTreeToggle', 'TelescopePrompt' },
	}
end

return M
