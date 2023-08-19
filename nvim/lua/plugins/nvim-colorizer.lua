local M = {}

M.default_options = function()
    return {
        filetypes = { "css", "html", "lua", "markdown", "scss", "text", "toml", "txt", "vim", "yaml" },
    }
end

return M
