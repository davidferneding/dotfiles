-- LEADER
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- REMAPPINGS
local bind = vim.keymap.set

function cmd (command)
    return '<cmd>' .. command .. '<cr>'
end


-- return to file explorer on ctrl-e -> x
bind('i', '<C-e>x', '<esc>'.. cmd(':Rex'))
bind('n', '<C-e>x', cmd(':Rex'))

-- save and reload lua file
bind({'i', 'n'}, '<C-r>f', cmd(':w') .. cmd(':luafile %'))
