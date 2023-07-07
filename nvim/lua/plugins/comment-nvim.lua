local M = {}
local api = require('Comment.api')

M.default_options = function()
    return {
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
            line = 'gcc',
            block = 'gbc',
        },
        opleader = {
            line = 'gc',
            block = 'gb',
        },
        extra = {
            above = 'gcO',
            below = 'gco',
            eol = 'gcA',
        },
        mappings = {
            basic = true,
            extra = true,
        },
        pre_hook = nil,
        post_hook = nil,
    }
end

vim.keymap.set('n', 'gcc', api.toggle.linewise.current)
vim.keymap.set('n', 'gcb', api.toggle.blockwise.current)

return M
