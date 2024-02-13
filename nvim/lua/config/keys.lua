-- LEADER
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- REMAPPINGS
local map = vim.api.nvim_set_keymap

map('i', '<C-e>x', '<esc><cmd>:Rex<cr>', {}) -- return to file explorer on ctrl-e -> x
map('i', '<C-r>lua', '<cmd>:w<cr><cmd>:luafile %<cr>', {}) -- save and reload lua file
