local M = {}

M.default_options = function ()
    return {
        layout = {
            max_width = { 100, 0.5 },
            width = nil,
            min_width = 10,
            default_direction = "prefer_right",
            -- default_direction = "float",
            placement = "window",
        },
    }
end

vim.keymap.set('n', '<C-p>', ':AerialToggle<CR>')

return M
