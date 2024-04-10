local opt = vim.opt
opt.number = true
opt.relativenumber = true
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#7777aa' } )
opt.signcolumn = "yes"
vim.g.netrw_bufsettings = 'noma nomod nu relativenumber nowrap ro nobl'

opt.syntax = 'ON'
opt.termguicolors = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4

opt.splitright = true
opt.splitbelow = true

vim.g.t_co = 256
