return {
	"simonmclean/triptych.nvim",
	event = "VeryLazy",
	keys = {
		{ "<C-n>", ":Triptych<CR>" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"antosha417/nvim-lsp-file-operations",
	},
	config = function()
		require("triptych").setup({
			options = {
				show_hidden = true,
			},
		})
	end,
}
