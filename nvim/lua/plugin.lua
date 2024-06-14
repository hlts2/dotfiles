local default_plugins = {
	--------------------------------
	-- Colorscheme plugins
	--------------------------------
	{
		"folke/tokyonight.nvim",
		lazy = false,
	},

	--------------------------------
	-- Git plugins
	--------------------------------
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},

	--------------------------------
	-- Search plugins
	--------------------------------
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		config = require("plugins/telescope-nvim").setup,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	--------------------------------
	-- Terminal Integration
	--------------------------------
	{
		"numToStr/FTerm.nvim",
		keys = require("plugins/FTerm-nvim").keys,
		config = require("plugins/FTerm-nvim").setup,
	},

	--------------------------------
	-- Util Plugins
	--------------------------------
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = require("plugins/dashboard-nvim").setup,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},

	{
		"NvChad/nvim-colorizer.lua",
		ft = require("plugins/nvim-colorizer").ft,
		config = require("plugins/nvim-colorizer").setup,
	},

	{
		"mvllow/modes.nvim",
		tag = "v0.2.0",
		config = require("plugins/modes-nvim").setup,
	},

	{
		"nvim-tree/nvim-web-devicons",
		config = require("plugins/nvim-web-devicons").setup,
	},

	{
		"nvim-focus/focus.nvim",
		tag = "v1.0.0",
		config = require("plugins/focus-nvim").setup,
	},

	{ "simeji/winresizer" },

	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		init = require("plugins/vim-startuptime").init,
	},

	{
		"stevearc/aerial.nvim",
		keys = require("plugins/aerial-nvim").keys,
		config = require("plugins/aerial-nvim").setup,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{
		"numToStr/Comment.nvim",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = require("plugins/Comment-nvim").setup,
	},

	--------------------------------
	-- UI plugins
	--------------------------------
	{
		"nvim-lualine/lualine.nvim",
		event = {
			"InsertEnter",
			"CursorHold",
			"FocusLost",
			"BufRead",
			"BufNewFile",
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"arkav/lualine-lsp-progress",
		},
		config = require("plugins/lualine-nvim").setup,
	},

	{
		"romgrk/barbar.nvim",
		version = "^1.0.0",
		init = require("plugins/barbar-nvim").init,
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	},

	{ "simeji/winresizer" },

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPre",
		init = require("plugins/indent-blankline-nvim").setup,
	},

	--------------------------------
	-- Syntax plugins
	--------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = {
			"BufReadPost",
			"BufNewFile",
		},
		config = require("plugins/nvim-treesitter").setup,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-treesitter/playground",
		},
	},

	--------------------------------
	-- File Explorer plugins
	--------------------------------
	{
		"nvim-tree/nvim-tree.lua",
		keys = require("plugins/nvim-tree").keys,
		config = require("plugins/nvim-tree").setup,
		dependencies = {
			"nvim-web-devicons",
		},
	},

	--------------------------------
	-- Completion plugins
	--------------------------------
	-- {
	--     'neoclide/coc.nvim',
	--     branch = 'release',
	--     config = function()
	--         require('plugins/coc')
	--     end,
	-- },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"hrsh7th/vim-vsnip",
			"hrsh7th/cmp-vsnip",
			"ray-x/cmp-treesitter",

			{
				"saecki/crates.nvim",
				tag = "stable",
				event = { "BufRead Cargo.toml" },
				config = require("plugins/crates-nvim").setup,
			},
		},
		config = require("plugins/nvim-cmp").setup,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		config = require("plugins/mason-lspconfig-nvim").setup,
		dependencies = {
			{
				"jay-babu/mason-null-ls.nvim",
				event = {
					"BufReadPre",
					"BufNewFile",
				},
				config = require("plugins/mason-null-ls-nvim").setup,
				dependencies = {
					{
						"williamboman/mason.nvim",
						cmd = {
							"Mason",
							"MasonInstall",
							"MasonInstallAll",
							"MasonUninstall",
							"MasonUninstallAll",
							"MasonLog",
						},
					},
					{
						"nvimtools/none-ls.nvim",
						config = require("plugins/null-ls-nvim").setup,
					},
				},
			},
			{ "neovim/nvim-lspconfig" },
		},
	},

	--------------------------------
	-- Go plugins
	--------------------------------
	{ "mattn/vim-goimports" },
	{ "mattn/vim-goaddtags" },
	{ "kyoh86/vim-go-coverage" },

	--------------------------------
	-- Rust plugins
	--------------------------------
	-- {
	-- 	"rust-lang/rust.vim",
	-- 	config = require("plugins/rust-vim").setup,
	-- },
	-- {
	-- 	"simrat39/rust-tools.nvim",
	-- 	config = require("plugins/rust-tools-nvim").setup,
	-- },

	--------------------------------
	-- Helm plugins
	--------------------------------
	{ "towolf/vim-helm" },
}

require("lazy").setup(default_plugins)

-----------------------------------
-- Appearance
-----------------------------------
vim.cmd.colorscheme("tokyonight-storm")
vim.cmd.syntax("enable")
