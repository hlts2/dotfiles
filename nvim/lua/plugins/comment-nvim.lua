local M = {}

M.default_options = function()
    return {
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
            line = '<Space>k',
            -- block = 'gbc',
        },
        opleader = {
            line = '<Space>k',
            -- block = 'gb',
        },
        mappings = {
            basic = true,
            extra = true,
        },
        pre_hook = nil,
        post_hook = nil,
    }
end

return M
