local M = {}

function M.setup()
	require("crates").setup({
		completion = {
			cmp = { enabled = true },
		},
	})
end

return M
