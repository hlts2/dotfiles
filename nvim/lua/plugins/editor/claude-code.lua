return {
	"greggh/claude-code.nvim",
	cmd = { "ClaudeCode", "ClaudeCodeContinue", "ClaudeCodeResume", "ClaudeCodeVerbose", "ClaudeCodeVersion" },
	keys = {
		{ "<C-,>", "<Cmd>ClaudeCode<CR>", desc = "Toggle Claude Code" },
		{ "<leader>cC", "<Cmd>ClaudeCodeContinue<CR>", desc = "Claude Code continue" },
		{ "<leader>cV", "<Cmd>ClaudeCodeVerbose<CR>", desc = "Claude Code verbose" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("claude-code").setup()
	end,
}
