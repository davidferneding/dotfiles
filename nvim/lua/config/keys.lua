-- LEADER
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- REMAPPINGS
local bind = vim.keymap.set

function cmd (command)
    return '<cmd>' .. command .. '<cr>'
end

-- saving / reloading
bind({'i', 'n'}, '<leader>sf', cmd(':w')) -- save file
bind({'i', 'n'}, '<leader>sa', cmd(':wa')) -- save all
bind({'i', 'n'}, '<leader>sq', cmd(':xa')) -- save all and quit
bind({'i', 'n'}, '<leader>qq', cmd(':qa')) -- quit without saving
bind({'i', 'n'}, '<leader>rf', cmd(':w') .. cmd(':luafile %')) -- save and reload lua file

-- nvim-tree
bind('i', '<leader>ts', '<esc>'.. cmd(':NvimTreeFocus')) -- focus file tree
bind('n', '<leader>ts', cmd(':NvimTreeFocus')) -- focus file tree
bind({'i', 'n'}, '<leader>th', cmd(':NvimTreeClose')) -- hide tree

-- new lines without leaving normal mode
bind('n', '<leader>o', 'o<Esc>') -- below
bind('n', '<leader>O', 'O<Esc>') -- above

-- search
bind({'i', 'n'}, '<leader>clh', cmd(':noh')) -- clear highlight
