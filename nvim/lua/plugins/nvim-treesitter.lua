local M = {}

function M.setup()
	require("nvim-treesitter.configs").setup({
		-- check install path: echo nvim_get_runtime_file('parser', v:true)
		ensure_installed = {
			"bash",
			"c",
			"cmake",
			"comment",
			"cpp",
			"cue",
			"dart",
			"diff",
			"dockerfile",
			"git_config",
			"git_rebase",
			"gitattributes",
			"gitcommit",
			"gitignore",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"graphql",
			"html",
			"http",
			"java",
			"javascript",
			"jsdoc",
			"json",
			"json5",
			"llvm",
			"lua",
			"luadoc",
			"make",
			"markdown",
			"ron",
			"rust",
			"sql",
			"terraform",
			"toml",
			"vim",
			"yaml",
			"zig",
		},
		ignore_install = {},
		sync_install = true,
		auto_install = false,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = true,
		},
		indent = {
			enable = true,
		},
		rainbow = {
			enable = true,
			extended_mode = true,
			max_file_lines = nil,
		},
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},
		matchup = {
			enable = true,
		},
		autotag = {
			enable = true,
		},
	})
end

return M
