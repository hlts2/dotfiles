return {
	"nvim-focus/focus.nvim",
	tag = "v1.0.0",
	event = "VeryLazy",
	config = function()
		require("focus").setup({
			enable = true,
		})
	end,
}
