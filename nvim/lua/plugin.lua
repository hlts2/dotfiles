local default_plugins = {
    -- Color thema
    {
        'cocopon/iceberg.vim',
        config = function()
            require('plugins/iceberg')
        end
    },

    -- Status line
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

    -- Profiling
    {
        'dstein64/vim-startuptime',
        cmd = "StartupTime",
        init = function()
            require('plugins/vim-startuptime')
        end,
    },

    -- Language server client
    {
        'neoclide/coc.nvim',
        branch = 'release',
        config = function()
            require('plugins/coc')
        end,
    },

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

    {'Townk/vim-autoclose'},

    {
        'numToStr/Comment.nvim',
        opts = function () 
            return require('plugins/comment-nvim')
        end,
        config = function (_, opts)
            require('Comment').setup(opts.default_options())
        end,
        lazy = false,
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

    -- Go
    {'mattn/vim-goimports'},
    {'mattn/vim-goaddtags'},
    {'kyoh86/vim-go-coverage'},

    -- Tree view
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

    -- Git
    {
        'lewis6991/gitsigns.nvim',
        opts = function ()
            return require('plugins/gitsigns-nvim')
        end,
        config = function (_, opts)
            require('gitsigns').setup(opts.default_options())
        end,
    }
}

require("lazy").setup(default_plugins)
