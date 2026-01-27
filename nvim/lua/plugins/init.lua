-- プラグイン仕様をカテゴリ別に読み込み
local plugins = {}

local categories = {
	-- UI関連（見た目）
	ui = {
		"colorscheme",
		"lualine",
		"indent-blankline",
		"modes",
		"devicons",
		"dashboard",
		"gitsigns",
	},
	-- エディタ機能
	editor = {
		"telescope",
		"treesitter",
		"comment",
		"autopairs",
		"aerial",
		"focus",
		"overlook",
	},
	-- LSP/補完関連
	lsp = {
		"mason",
		"servers",
		"cmp",
		"format",
	},
	-- 言語固有
	lang = {
		"go",
		"rust",
		"helm",
	},
	-- ユーティリティ
	tools = {
		"fterm",
		"triptych",
		"colorizer",
		"startuptime",
	},
}

for category, files in pairs(categories) do
	for _, file in ipairs(files) do
		local ok, plugin = pcall(require, "plugins." .. category .. "." .. file)
		if ok then
			if plugin[1] then
				-- 単一プラグイン or 複数プラグインの配列
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
