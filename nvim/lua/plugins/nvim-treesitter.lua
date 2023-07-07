local M = {}

M.default_options = function ()
    return {
        ensure_installed = {
            'cue',
        },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            disable = {'go'}
        },
    }
end

return M
