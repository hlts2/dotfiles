local default_plugins = {
    --------------------------------
    -- Colorscheme plugins
    --------------------------------
    {
        'cocopon/iceberg.vim',
        config = function()
            require('plugins/iceberg')
        end
    },

    --------------------------------
    -- Style plugins
    --------------------------------
    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufReadPre',
        opts = function()
            return require('plugins/indent-blankline-nvim')
        end,
        config = function(_, opts)
            require('indent_blankline').setup(opts.default_options())
        end,
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        opts = function ()
            return require('plugins/lualine-nvim')
        end,
        config = function (_, opts)
            require('lualine').setup(opts.default_options())
        end,
    },

    --------------------------------
    -- Terminal plugins
    --------------------------------
    {
        'numToStr/FTerm.nvim',
        keys = {"<C-i>"},
        opts = function()
            return require('plugins/FTerm-nvim')
        end,
        config = function(_, opts)
            require('FTerm').setup(opts.default_options())
        end,
    },

    --------------------------------
    -- Behavior plugins
    --------------------------------
    {
        'stevearc/aerial.nvim',
        opts = function ()
            return require('plugins/aerial-nvim')
        end,
        config = function (_, opts)
            require('aerial').setup(opts.default_options())
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    },

    {
        "beauwilliams/focus.nvim",
        opts = function()
            return require('plugins/focus-nvim')
        end,
        config = function(_, opts)
            require("focus").setup(opts.default_options())
        end,
    },
    {
        "simeji/winresizer",
        config = function ()
            require('plugins/winresizer')
        end,
    },

    {
        'nvim-tree/nvim-web-devicons',
        opts = function()
            return require('plugins/nvim-web-devicons')
        end,
        config = function (_, opts)
            require('nvim-web-devicons').setup(opts)
        end,
    },

    {
        'nvim-tree/nvim-tree.lua',
        after = 'nvim-web-devicons',
        opts = function()
            return require('plugins/nvim-tree')
        end,
        config = function(_, opts)
            require('nvim-tree').setup(opts.default_options())
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
        opts = function()
            return require('plugins/nvim-treesitter')
        end,
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts.default_options())
        end,
    },

    --------------------------------
    -- Comment plugins
    --------------------------------
    {
        'numToStr/Comment.nvim',
        event = 'BufReadPre',
        opts = function ()
            return require('plugins/comment-nvim')
        end,
        config = function (_, opts)
            require('Comment').setup(opts.default_options())
        end,
    },

    --------------------------------
    -- Go plugins
    --------------------------------
    {'mattn/vim-goimports'},
    {'mattn/vim-goaddtags'},
    {'kyoh86/vim-go-coverage'},



    -- Fuzzy finder over lists
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        opts = function()
            return require('plugins/telescope-nvim')
        end,
        config = function (_, opts)
            require('telescope').setup(opts.default_options())
        end,
    },

    --------------------------------
    -- Git plugins
    --------------------------------
    {
        'lewis6991/gitsigns.nvim',
        opts = function ()
            return require('plugins/gitsigns-nvim')
        end,
        config = function (_, opts)
            require('gitsigns').setup(opts.default_options())
        end,
    },

    --------------------------------
    -- Misc plugins
    --------------------------------
    {'Townk/vim-autoclose'},
}

require("lazy").setup(default_plugins)
