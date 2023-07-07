vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.softtabstop=0
vim.opt.smarttab=true
vim.opt.expandtab=true
vim.opt.autoindent=true
vim.opt.number=true
vim.opt.mouse='a'
vim.opt.swapfile=false

vim.g.mapleader = " "
vim.keymap.set('n', 'st', ':tabnew<Enter>')
vim.keymap.set('n', 'ss', ':split<Enter>')
vim.keymap.set('n', 'sv', ':vsplit<Enter>')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
