return {
	"NvChad/nvim-colorizer.lua",
	ft = {
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
	},
	config = function()
		require("colorizer").setup({
			filetypes = {
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
			},
			css = { rgb_fn = true },
		})
	end,
}
