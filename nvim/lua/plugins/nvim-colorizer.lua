local M = {}

function M.ft()
	return {
		"css",
		"html",
		"lua",
		"markdown",
		"scss",
		"text",
		"toml",
		"txt",
		"vim",
		"yaml",
	}
end

function M.setup()
	require("colorizer").setup({
		filetypes = M.ft(),
        css = { rgb_fn = true; },
	})
end

return M
