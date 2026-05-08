return {
	"greggh/claude-code.nvim",
	cmd = { "ClaudeCode", "ClaudeCodeVersion" },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("claude-code").setup()
	end,
}
