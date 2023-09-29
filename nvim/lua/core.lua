vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.swapfile = false

vim.g.mapleader = " "
vim.keymap.set("n", "st", ":tabnew<Enter>")
vim.keymap.set("n", "ss", ":split<Enter>")
vim.keymap.set("n", "sv", ":vsplit<Enter>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

-- autocmd BufWritePre * :%s/\s\+$//ge
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = "*",
	command = ":%s/\\s\\+$//ge",
})

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option("updatetime", 300)

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- NOTE: Copy: Shift + Command + c
