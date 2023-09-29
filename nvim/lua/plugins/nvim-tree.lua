local M = {}

local opts = function(desc)
	-- return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	return { desc = "nvim-tree: " .. desc, noremap = true, silent = true, nowait = true }
end

function M.on_attach(bufnr)
	local api = require("nvim-tree.api")
	api.config.mappings.default_on_attach(bufnr)
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

function M.keys()
	return {
		{ "<C-n>", "<CMD>NvimTreeToggle<CR>", opts("Help") },
	}
end

function M.init()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
end

function M.setup()
	require("nvim-tree").setup({
		sort_by = "case_sensitive",
		view = {
			width = "20%",
			side = "left",
			signcolumn = "no",

			float = {
				enable = true,
				open_win_config = {
					width = 50,
				},
			},
		},
		renderer = {
			highlight_git = true,
			highlight_opened_files = "name",
			group_empty = true,
			full_name = true,
			indent_width = 2,
			indent_markers = {
				enable = true,
			},
			icons = {
				glyphs = {
					git = {
						unstaged = "!",
						renamed = "»",
						untracked = "?",
						deleted = "✘",
						staged = "✓",
						unmerged = "",
						ignored = "◌",
					},
				},
			},
		},
		filters = {
			dotfiles = false,
		},
		on_attach = M.on_attach,
	})
end

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- -- vim.opt.termguicolors = true
--
-- vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", opts("Help"))

return M
