-- LEADER
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- REMAPPINGS
local bind = vim.keymap.set

local function cmd (command)
    return '<cmd>' .. command .. '<cr>'
end

-- saving / reloading
bind({'i', 'n'}, '<leader>sf', cmd(':w')) -- save file
bind({'i', 'n'}, '<leader>sc', cmd(':w') .. cmd(':bdelete') .. cmd(':bprevious')) -- save file and close buffer
bind({'i', 'n'}, '<leader>sa', cmd(':wa')) -- save all
bind({'i', 'n'}, '<leader>sq', cmd(':xa')) -- save all and quit
bind({'i', 'n'}, '<leader>qq', cmd(':qa')) -- quit without saving
bind({'i', 'n'}, '<leader>rf', cmd(':w') .. cmd(':luafile %')) -- save and reload lua file

-- system clipboard
bind({'n', 'v'}, '<leader>y', '"+y')
bind('n', '<leader>Y', '"+yg_')

-- nvim-tree
bind('i', '<leader>ts', '<esc>'.. cmd(':NvimTreeFocus')) -- focus file tree
bind('n', '<leader>ts', cmd(':NvimTreeFocus')) -- focus file tree
bind({'i', 'n'}, '<leader>th', cmd(':NvimTreeClose')) -- hide tree

-- new lines without leaving normal mode
bind('n', '<leader>o', 'o<Esc>') -- below
bind('n', '<leader>O', 'O<Esc>') -- above

-- search
bind({'i', 'n'}, '<leader>clh', cmd(':noh')) -- clear highlight

-- telescope
bind({'i', 'n'}, '<leader>tf', cmd(':Telescope find_files'))
bind({'i', 'n'}, '<leader>tg', cmd(':Telescope live_grep'))

-- mason
bind({'i', 'n'}, '<leader>lspu', cmd(':Mason'))

-- harpoon
bind({'i', 'n'}, '<leader>ha', cmd(':HarpoonAppend'))
bind({'i', 'n'}, '<leader>hr', cmd(':HarpoonRemove'))
bind({'i', 'n'}, '<leader>hs', cmd(':HarpoonShow'))
bind({'i', 'n'}, '<leader>hn', cmd(':HarpoonNext'))
bind({'i', 'n'}, '<leader>hp', cmd(':HarpoonPrev'))

bind({'i', 'n'}, '<leader>h1', cmd(':HarpoonSwitch 1'))
bind({'i', 'n'}, '<leader>h2', cmd(':HarpoonSwitch 2'))
bind({'i', 'n'}, '<leader>h3', cmd(':HarpoonSwitch 3'))
bind({'i', 'n'}, '<leader>h4', cmd(':HarpoonSwitch 4'))
bind({'i', 'n'}, '<leader>h5', cmd(':HarpoonSwitch 5'))
bind({'i', 'n'}, '<leader>h6', cmd(':HarpoonSwitch 6'))
bind({'i', 'n'}, '<leader>h7', cmd(':HarpoonSwitch 7'))
bind({'i', 'n'}, '<leader>h8', cmd(':HarpoonSwitch 8'))
bind({'i', 'n'}, '<leader>h9', cmd(':HarpoonSwitch 9'))

-- resize windows
bind('n', '<S-Up>', cmd(':res -1'))
bind('n', '<S-Down>', cmd(':res +1'))
bind('n', '<S-Left>', cmd(':vert res +1'))
bind('n', '<S-Right>', cmd(':vert res -1'))

-- diff / merge
bind('n', '<leader>dn', ']c') -- next diff
bind('n', '<leader>dp', '[c') -- prev diff
bind('n', '<leader>dg', cmd(':diffget')) -- use other change (two way diff)
bind('n', '<leader>dl', cmd(':diffget local')) -- use local change
bind('n', '<leader>dr', cmd(':diffget remote')) -- use change from remote

-- notes
bind({'i', 'n'}, '<leader>gn', cmd(':GlobalNote'))
