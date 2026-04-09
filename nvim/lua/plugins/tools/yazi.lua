return {
	"mikavilpas/yazi.nvim",
	version = "*",
	event = "VeryLazy",
	keys = {
		{ "<C-n>", "<Cmd>Yazi<CR>" },
	},
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	opts = {
		open_for_directories = true,
	},
}
