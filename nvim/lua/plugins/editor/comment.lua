return {
	"numToStr/Comment.nvim",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		require("Comment").setup({
			padding = true,
			sticky = true,
			ignore = nil,
			toggler = {
				line = "<Space>k",
			},
			opleader = {
				line = "<Space>k",
			},
			mappings = {
				basic = true,
				extra = true,
			},
			pre_hook = nil,
			post_hook = nil,
		})
	end,
}
