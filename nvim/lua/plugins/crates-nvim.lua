local M = {}

function M.setup()
	require("crates").setup({
		src = {
			cmp = { enabled = true },
		},
	})
end

return M
