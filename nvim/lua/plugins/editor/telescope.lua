return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.4",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
		{ "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
		{ "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
		{ "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help tags" },
		{ "<leader>fd", function() require("telescope.builtin").lsp_definitions() end, desc = "Find definition" },
		{ "<leader>fi", function() require("telescope.builtin").lsp_implementations() end, desc = "Find implementation" },
		{ "<leader>fr", function() require("telescope.builtin").lsp_references() end, desc = "Find reference" },
		{ "<leader>ft", function() require("telescope.builtin").lsp_type_definitions() end, desc = "Find type definition" },
		{ "<leader>fs", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Find symbols (file)" },
		{ "<leader>fS", function() require("telescope.builtin").lsp_workspace_symbols() end, desc = "Find symbols (workspace)" },
	},
	config = function()
		local telescope = require("telescope")
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
	end,
}
