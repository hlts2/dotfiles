return {
	"WilliamHsieh/overlook.nvim",
	opts = {},

	keys = {
		{
			"<leader>od",
			function()
				require("overlook.api").peek_definition()
			end,
			desc = "Overlook: Peek definition",
		},
		{
			"<leader>oc",
			function()
				require("overlook.api").close_all()
			end,
			desc = "Overlook: Close all popup",
		},
		{
			"<leader>ou",
			function()
				require("overlook.api").restore_popup()
			end,
			desc = "Overlook: Restore popup",
		},
	},
}
