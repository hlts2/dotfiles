local M = {}

M.default_options = function()
	return {
		layout = {
			max_width = { 100, 0.5 },
			width = nil,
			min_width = 10,
			-- default_direction = "prefer_right",
			default_direction = "float",
			placement = "window",
			attach_mode = "global",
			-- placement = "edge",
		},

		autojump = true,
		highlight_on_hover = true,
		close_on_select = true,

		float = {
			relative = "editor",
			max_width = { 100, 0.5 },
			width = nil,
			min_width = 10,
		},
	}
end

vim.keymap.set("n", "<C-b>", ":AerialToggle<CR>")

return M
