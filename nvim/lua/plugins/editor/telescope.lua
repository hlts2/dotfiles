return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.4",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
			pickers = {
				find_files = {
					-- theme = "dropdown",
				},
			},
		})

		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

		vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, { desc = "Find definition" })
		vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, { desc = "Find implementation"})
		vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Find reference" })
		vim.keymap.set("n", "<leader>ft", builtin.lsp_type_definitions, { desc = "Find type definition"})

		vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = 'Find symbols (file)' })
		vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = 'Find symbols (workspace)' })
	end,
}
