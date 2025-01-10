local M = {}

function M.setup()
	require("triptych").setup({
		options = {
			show_hidden = true,
		},
	})
end

function M.keys()
	return {
		{ "<C-n>", ":Triptych<CR>" },
	}
end

return M
