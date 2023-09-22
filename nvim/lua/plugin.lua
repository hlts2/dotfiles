local default_plugins = {
	--------------------------------
	-- Colorscheme plugins
	--------------------------------
	{
		-- "bluz71/vim-nightfly-colors",
		-- name = "nightfly",
		"folke/tokyonight.nvim",
		lazy = false,
		config = function()
			require("plugins/color-scheme")
		end,
	},

	--------------------------------
	-- Bars and Lines plugins
	--------------------------------
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = function()
			return require("plugins/lualine-nvim").default_options()
		end,
	},

	{
		"romgrk/barbar.nvim",
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		-- init = function() vim.g.barbar_auto_setup = false end,
	},

	{
		"mvllow/modes.nvim",
		tag = "v0.2.0",
		opts = function()
			return require("plugins/modes-nvim").default_options()
		end,
	},

	--------------------------------
	-- Color plugins
	--------------------------------
	{
		"NvChad/nvim-colorizer.lua",
		ft = {
			"css",
			"html",
			"lua",
			"markdown",
			"scss",
			"text",
			"toml",
			"txt",
			"vim",
			"yaml",
		},
		opts = function()
			return require("plugins/nvim-colorizer").default_options()
		end,
	},

	--------------------------------
	-- Icon plugins
	--------------------------------
	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			return require("plugins/nvim-web-devicons").default_options()
		end,
	},

	--------------------------------
	-- Split and Window plugins
	--------------------------------
	{
		"beauwilliams/focus.nvim",
		tag = "v1.0.0",
		opts = function()
			return require("plugins/focus-nvim").default_options()
		end,
	},
	{
		"simeji/winresizer",
		config = function()
			require("plugins/winresizer")
		end,
	},

	--------------------------------
	-- Indent plugins
	--------------------------------
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		opts = function()
			return require("plugins/indent-blankline-nvim").default_options()
		end,
	},

	--------------------------------
	-- Syntax plugins
	--------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-treesitter/playground",
		},
		opts = function()
			return require("plugins/nvim-treesitter").default_options()
		end,
	},

	--------------------------------
	-- Startup plugins
	--------------------------------
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		init = function()
			require("plugins/vim-startuptime")
		end,
	},

	--------------------------------
	-- Terminal Integration plugins
	--------------------------------
	{
		"numToStr/FTerm.nvim",
		keys = { "<C-l>" },
		opts = function()
			return require("plugins/FTerm-nvim").default_options()
		end,
	},

	--------------------------------
	-- File Explorer plugins
	--------------------------------
	{
		"nvim-tree/nvim-tree.lua",
		after = "nvim-web-devicons",
		opts = function()
			return require("plugins/nvim-tree").default_options()
		end,
	},

	--------------------------------
	-- Auto-completion plugins
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
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"neovim/nvim-lspconfig",
			"petertriho/cmp-git",
			"ray-x/cmp-treesitter",
		},
		config = function()
			require("plugins/nvim-cmp").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
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
				dependencies = {
					"neovim/nvim-lspconfig",
				},
			},
		},
		config = function()
			require("plugins/mason-lspconfig-nvim").setup()
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufWritePre" },
		config = function()
			require("plugins/null-ls-nvim").setup()
		end,
		dependencies = {
			{
				"jay-babu/mason-null-ls.nvim",
				opts = require("./plugins/mason-null-ls-nvim").default_options(),
			},
		},
	},

	--------------------------------
	-- Fuzzy finder plugins
	--------------------------------
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = function()
			return require("plugins/telescope-nvim").default_options()
		end,
	},

	--------------------------------
	-- Git plugins
	--------------------------------
	{
		"lewis6991/gitsigns.nvim",
		opts = function()
			return require("plugins/gitsigns-nvim").default_options()
		end,
	},

	--------------------------------
	-- Editing Support plugins
	--------------------------------
	{ "Townk/vim-autoclose" },

	{
		"numToStr/Comment.nvim",
		event = "BufReadPre",
		opts = function()
			return require("plugins/comment-nvim").default_options()
		end,
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
	{
		"rust-lang/rust.vim",
		config = function()
			require("plugins.rust-vim")
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		config = function()
			require("plugins/rust-tools-nvim").setup()
		end,
	},

	--------------------------------
	-- Helm plugins
	--------------------------------
	{
		"towolf/vim-helm",
	},

	--------------------------------
	-- Misc plugins
	--------------------------------
	{
		"stevearc/aerial.nvim",
		opts = function()
			return require("plugins/aerial-nvim").default_options()
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
}

require("lazy").setup(default_plugins)
