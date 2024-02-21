-- LEADER
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- REMAPPINGS
local bind = vim.keymap.set

function cmd (command)
    return '<cmd>' .. command .. '<cr>'
end

-- saving / reloading
bind({'i', 'n'}, '<C-s>f', cmd(':w')) -- save file
bind({'i', 'n'}, '<C-s>a', cmd(':wa')) -- save all
bind({'i', 'n'}, '<C-s>q', cmd(':xa')) -- save all and quit
bind({'i', 'n'}, '<C-q>q', cmd(':qa')) -- quit without saving
bind({'i', 'n'}, '<C-r>f', cmd(':w') .. cmd(':luafile %')) -- save and reload lua file

-- nvim-tree
bind('i', '<C-e>x', '<esc>'.. cmd(':NvimTreeFocus')) -- focus file tree on ctrl+e->x
bind('n', '<C-e>x', cmd(':NvimTreeFocus')) -- focus file tree on ctrl+e->x
bind({'i', 'n'}, '<C-t>h', cmd(':NvimTreeClose')) -- hide tree

-- new lines without leaving normal mode
bind('n', '<leader>o', 'o<Esc>') -- below
bind('n', '<leader>O', 'O<Esc>') -- above

-- search
bind({'i', 'n'}, '<leader>clears', cmd(':noh')) -- clear highlight
