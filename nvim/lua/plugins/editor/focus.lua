return {
	"nvim-focus/focus.nvim",
	tag = "v1.0.0",
	config = function()
		require("focus").setup({
			enable = true,
		})
	end,
}
