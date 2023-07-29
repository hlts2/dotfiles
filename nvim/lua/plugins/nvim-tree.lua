local M = {}
local opts = function(desc)
     return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

local on_attach = function(bufnr)
    local api = require('nvim-tree.api')
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

M.default_options = function()
    return {
        sort_by = "case_sensitive",
        view = {
            width = '20%',
            side = 'left',
            signcolumn = 'no',

            float = {
                enable = true,
                open_win_config = {
                    width = 50,
                }
            }
        },
        renderer = {
            highlight_git = true,
            highlight_opened_files = 'name',
            group_empty = true,
            full_name = true,
            indent_width = 2,
            indent_markers = {
                enable = true,
            },
            icons = {
                glyphs = {
                    git = {
                        unstaged = '!', renamed = '»',  untracked = '?', deleted = '✘',
                        staged = '✓',   unmerged = '', ignored = '◌',
                    },
                },
            },
        },
        filters = {
            dotfiles = false,
        },
        on_attach = on_attach,
    }
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.opt.termguicolors = true

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', opts('Help'))

return M
