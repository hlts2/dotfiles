return {
	"numToStr/FTerm.nvim",
	keys = { "<C-a>" },
	config = function()
		require("FTerm").setup({
			border = "double",
			dimensions = {
				height = 0.9,
				width = 0.9,
			},
		})
		vim.keymap.set("n", "<C-a>", '<CMD>lua require("FTerm").toggle()<CR>')
		vim.keymap.set("t", "<C-a>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
	end,
}
