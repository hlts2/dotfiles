-- Load plugin specs by category
local plugins = {}

local categories = {
	-- UI (appearance)
	ui = {
		"colorscheme",
		"lualine",
		"indent-blankline",
		"modes",
		"devicons",
		"gitsigns",
		"render-markdown",
	},
	-- Editor features
	editor = {
		"aerial",
		"autopairs",
		"claude-code",
		"comment",
		"overlook",
		"telescope",
		"treesitter",
	},
	-- LSP/Completion
	lsp = {
		"mason",
		"tool-installer",
		"servers",
		"cmp",
		"format",
	},
	-- Language specific
	lang = {
		"go",
		"rust",
		"helm",
	},
	-- Utilities
	tools = {
		"colorizer",
		"startuptime",
		"yazi",
	},
}

for category, files in pairs(categories) do
	for _, file in ipairs(files) do
		local ok, plugin = pcall(require, "plugins." .. category .. "." .. file)
		if ok then
			if plugin[1] then
				-- Single plugin or array of multiple plugins
				if type(plugin[1]) == "string" then
					table.insert(plugins, plugin)
				else
					for _, p in ipairs(plugin) do
						table.insert(plugins, p)
					end
				end
			end
		end
	end
end

return plugins
