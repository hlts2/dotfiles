return {
	"stevearc/aerial.nvim",
	keys = {
		{ "<C-b>", "<CMD>AerialToggle<CR>" },
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("aerial").setup({
			layout = {
				max_width = { 100, 0.5 },
				width = nil,
				min_width = 10,
				default_direction = "float",
				placement = "window",
				attach_mode = "global",
			},
			autojump = true,
			highlight_on_hover = true,
			close_on_select = true,
			float = {
				relative = "editor",
				max_width = { 100, 0.5 },
				width = nil,
				min_width = 10,
			},
		})
	end,
}
