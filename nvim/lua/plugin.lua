local default_plugins = {
    --------------------------------
    -- Colorscheme plugins
    --------------------------------
    {
        -- "folke/tokyonight.nvim",
        -- "bluz71/vim-nightfly-colors",
        -- name = "nightfly",
        "folke/tokyonight.nvim",
        -- 'cocopon/iceberg.vim',
        lazy = false,
        config = function()
            require('plugins/color-scheme')
        end
    },

    --------------------------------
    -- Style plugins
    --------------------------------
    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufReadPre',
        opts = function()
            return require('plugins/indent-blankline-nvim').default_options()
        end,
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        opts = function()
            return require('plugins/lualine-nvim').default_options()
        end,
    },

    --------------------------------
    -- Terminal plugins
    --------------------------------
    {
        'numToStr/FTerm.nvim',
        keys = { '<S-o>' },
        opts = function()
            return require('plugins/FTerm-nvim').default_options()
        end,
    },

    --------------------------------
    -- Behavior plugins
    --------------------------------
    {
        'stevearc/aerial.nvim',
        opts = function()
            return require('plugins/aerial-nvim').default_options()
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },

    {
        "beauwilliams/focus.nvim",
        tag = 'v1.0.0',
        opts = function()
            return require('plugins/focus-nvim').default_options()
        end,
    },
    {
        "simeji/winresizer",
        config = function()
            require('plugins/winresizer')
        end,
    },

    {
        'nvim-tree/nvim-web-devicons',
        opts = function()
            return require('plugins/nvim-web-devicons').default_options()
        end,
    },

    {
        'nvim-tree/nvim-tree.lua',
        after = 'nvim-web-devicons',
        opts = function()
            return require('plugins/nvim-tree').default_options()
        end,
    },

    --------------------------------
    -- Profiling plugins
    --------------------------------
    {
        'dstein64/vim-startuptime',
        cmd = "StartupTime",
        init = function()
            require('plugins/vim-startuptime')
        end,
    },

    --------------------------------
    -- Auto-completion plugins
    --------------------------------
    {
        'neoclide/coc.nvim',
        branch = 'release',
        config = function()
            require('plugins/coc')
        end,
    },

    --------------------------------
    -- Treesitter plugins
    --------------------------------
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-treesitter/playground',
        },
        opts = function()
            return require('plugins/nvim-treesitter').default_options()
        end,
    },

    --------------------------------
    -- Comment plugins
    --------------------------------
    {
        'numToStr/Comment.nvim',
        event = 'BufReadPre',
        opts = function()
            return require('plugins/comment-nvim').default_options()
        end,
    },

    --------------------------------
    -- Go plugins
    --------------------------------
    { 'mattn/vim-goimports' },
    { 'mattn/vim-goaddtags' },
    { 'kyoh86/vim-go-coverage' },


    --------------------------------
    -- Rust plugins
    --------------------------------
    {
        'rust-lang/rust.vim',
        config = function()
            require('plugins.rust-vim')
        end,
    },

    -- Fuzzy finder over lists
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        opts = function()
            return require('plugins/telescope-nvim').default_options()
        end,
    },

    --------------------------------
    -- Git plugins
    --------------------------------
    {
        'lewis6991/gitsigns.nvim',
        opts = function()
            return require('plugins/gitsigns-nvim').default_options()
        end,
    },

    --------------------------------
    -- Misc plugins
    --------------------------------
    { 'Townk/vim-autoclose' },

    {
        'NvChad/nvim-colorizer.lua',
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
            return require('plugins/nvim-colorizer').default_options()
        end,
    }
}

require("lazy").setup(default_plugins)
