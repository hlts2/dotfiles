local M = {}

M.default_options = function()
	return {
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
			"markdown",
			"markdown-inline",
			"java",
			"javascript",
			"jsdoc",
			"json",
			"json5",
			"llvm",
			"lua",
			"luadoc",
			"make",
			"rust",
			"sql",
			"terraform",
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
	}
end

return M
