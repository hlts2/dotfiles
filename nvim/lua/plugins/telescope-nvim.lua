local M = {}
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

M.default_options = function()
    return {
        defaults = {
            i = {
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
            },
        },
        pickers = {
            find_files = {
                -- theme = "dropdown",
            },
        },
    }
end

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

return M
