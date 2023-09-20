-- LSP Diagnostics Options Setup
-- local sign = function(opts)
--   vim.fn.sign_define(opts.name, {
--     texthl = opts.name,
--     text = opts.text,
--     numhl = ''
--   })
-- end
--
-- sign({name = 'DiagnosticSignError', text = ''})
-- sign({name = 'DiagnosticSignWarn', text = ''})
-- sign({name = 'DiagnosticSignHint', text = ''})
-- sign({name = 'DiagnosticSignInfo', text = ''})
--
-- vim.diagnostic.config({
--     virtual_text = false,
--     signs = true,
--     update_in_insert = true,
--     underline = true,
--     severity_sort = false,
--     float = {
--         border = 'rounded',
--         source = 'always',
--         header = '',
--         prefix = '',
--     },
-- })
--
-- vim.cmd([[
-- set signcolumn=yes
-- autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
-- ]])
--
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
            require('plugins/color-scheme')
        end
    },

    --------------------------------
    -- Bars and Lines plugins
    --------------------------------
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        opts = function()
            return require('plugins/lualine-nvim').default_options()
        end,
    },

    {
        'romgrk/barbar.nvim',
        version = '^1.0.0',                -- optional: only update when a new 1.x version is released
        dependencies = {
            'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        -- init = function() vim.g.barbar_auto_setup = false end,
    },

    {
        'mvllow/modes.nvim',
        tag = 'v0.2.0',
        opts = function()
            return require('plugins/modes-nvim').default_options()
        end,
    },

    --------------------------------
    -- Color plugins
    --------------------------------
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
    },

    --------------------------------
    -- Icon plugins
    --------------------------------
    {
        'nvim-tree/nvim-web-devicons',
        opts = function()
            return require('plugins/nvim-web-devicons').default_options()
        end,
    },

    --------------------------------
    -- Split and Window plugins
    --------------------------------
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

    --------------------------------
    -- Indent plugins
    --------------------------------
    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufReadPre',
        opts = function()
            return require('plugins/indent-blankline-nvim').default_options()
        end,
    },

    --------------------------------
    -- Syntax plugins
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
    -- Startup plugins
    --------------------------------
    {
        'dstein64/vim-startuptime',
        cmd = "StartupTime",
        init = function()
            require('plugins/vim-startuptime')
        end,
    },

    --------------------------------
    -- Terminal Integration plugins
    --------------------------------
    {
        'numToStr/FTerm.nvim',
        keys = { '<S-o>' },
        opts = function()
            return require('plugins/FTerm-nvim').default_options()
        end,
    },

    --------------------------------
    -- File Explorer plugins
    --------------------------------
    {
        'nvim-tree/nvim-tree.lua',
        after = 'nvim-web-devicons',
        opts = function()
            return require('plugins/nvim-tree').default_options()
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
        'williamboman/mason-lspconfig.nvim',
        -- event = "InsertEnter",
        opts = {
            ui = {
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
            },
            ensure_installed = {
                "rust_analyzer",
            },
            automatic_installation = true,
        },
        config = function(_, opts)
            require("mason").setup()
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")

            mason_lspconfig.setup(opts)
            mason_lspconfig.setup_handlers {
                function(server_name)
                    local opts = {}
                    lspconfig[server_name].setup(opts)
                end,
            }
        end,
        dependencies = {
            'williamboman/mason.nvim',
            cmd = {
                'Mason',
                'MasonInstall',
                'MasonInstallAll',
                'MasonUninstall',
                'MasonUninstallAll',
                'MasonLog',
            },
            event = 'InsertEnter',
            config = true,
            dependencies = 'neovim/nvim-lspconfig',
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "InsertEnter", "CmdlineEnter" },
        lazy = true,
        keys = function()
            local opts = { noremap = true, silent = true }
            return {
                {
                    "gD",
                    vim.lsp.buf.declaration,
                    opts,
                    desc = "Go To Declaration",
                    mode = "n",
                    silent = true,
                    noremap = true,
                },
                {
                    "gi",
                    vim.lsp.buf.implementation,
                    opts,
                    desc = "Go To Implementation",
                    mode = "n",
                    silent = true,
                    noremap = true,
                },
                {
                    "<leader>k",
                    vim.lsp.buf.signature_help,
                    opts,
                    desc = "Show Signature",
                    mode = "n",
                    silent = true,
                    noremap = true,
                },
                {
                    "<Leader>gr",
                    vim.lsp.buf.references,
                    opts,
                    desc = "Go To References",
                    mode = "n",
                    silent = true,
                    noremap = true,
                },
                {
                    "<Leader>D",
                    vim.lsp.buf.type_definition,
                    opts,
                    desc = "Show Type Definition",
                    mode = "n",
                    silent = true,
                    noremap = true,
                },
                {
                    "K",
                    vim.lsp.buf.hover,
                    desc = "Show Info",
                    mode = "n",
                    silent = true,
                    noremap = true,
                },
            }
        end,
    },
    {
        'simrat39/rust-tools.nvim',
        config = function()
            local rt = require("rust-tools")
            rt.setup({
                server = {
                    on_attach = function(_, bufnr)
                        -- Hover actions
                        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                        -- Code action groups
                        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                    end,
                },
            })
        end
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'hrsh7th/cmp-vsnip' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/vim-vsnip' },
        },
        config = function()
            local cmp = require 'cmp'
            cmp.setup({
                -- Enable LSP snippets
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = {
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    -- Add tab support
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    })
                },
                -- Installed sources:
                sources = {
                    { name = 'path' },                                       -- file paths
                    { name = 'nvim_lsp',               keyword_length = 3 }, -- from language server
                    { name = 'nvim_lsp_signature_help' },                    -- display function signatures with current parameter emphasized
                    { name = 'nvim_lua',               keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
                    { name = 'buffer',                 keyword_length = 2 }, -- source current buffer
                    { name = 'vsnip',                  keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
                    { name = 'calc' },                                       -- source for math calculation
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = {
                    fields = { 'menu', 'abbr', 'kind' },
                    format = function(entry, item)
                        local menu_icon = {
                            nvim_lsp = 'λ',
                            vsnip = '⋗',
                            buffer = 'Ω',
                            path = '🖫',
                        }
                        item.menu = menu_icon[entry.source.name]
                        return item
                    end,
                },
            })
        end
    },

    --------------------------------
    -- Fuzzy finder plugins
    --------------------------------
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
    -- Editing Support plugins
    --------------------------------
    { 'Townk/vim-autoclose' },

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
    -- {
    --     'rust-lang/rust.vim',
    --     config = function()
    --         require('plugins.rust-vim')
    --     end,
    -- },

    --------------------------------
    -- Helm plugins
    --------------------------------
    {
        'towolf/vim-helm',
    },

    --------------------------------
    -- Misc plugins
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
}

require("lazy").setup(default_plugins)
