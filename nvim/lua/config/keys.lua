-- LEADER
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- REMAPPINGS
local bind = vim.keymap.set
bind({ 'i', 'v' }, 'jk', '<Esc>', { desc = 'Back to normal mode' })

local cmd = function(command)
    return '<cmd>' .. command .. '<cr>'
end

-- saving / reloading
bind('n', '<leader>rf', cmd(':w') .. cmd(':luafile %'), { desc = 'save and reload lua file' })

-- lsp
local lspbuf = vim.lsp.buf
bind('n', '<leader>jd', lspbuf.definition, { desc = 'jump to definition' })
bind('n', '<leader>ji', lspbuf.implementation, { desc = 'jump to implementation' })
bind('n', '<leader>jc', lspbuf.incoming_calls, { desc = 'jump to incoming calls' })
bind('n', '<leader>jr', lspbuf.references, { desc = 'jump to references' })
bind({ 'i', 'n' }, '<C-i>', lspbuf.hover, { desc = 'show hover information' })
bind({ 'i', 'n' }, '<C-a>', lspbuf.code_action, { desc = 'show code actions' })
bind('n', '<leader>rn', lspbuf.rename, { desc = 'rename' })
bind('n', '<leader>ff', lspbuf.format, { desc = 'format file' })
bind('v', '<leader>ff', lspbuf.format, { desc = 'format range' })

-- system clipboard
bind({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'copy to system clipboard' })
bind('n', '<leader>Y', '"+yg_', { desc = 'copy to system clipboard' })

-- nvim-tree
bind('n', '<leader>ts', cmd(':NvimTreeFocus'), { desc = 'focus file tree' })
bind('n', '<leader>th', cmd(':NvimTreeClose'), { desc = 'hide tree' })

-- new lines without leaving normal mode
bind('n', '<leader>o', 'o<Esc>', { desc = 'below' })
bind('n', '<leader>O', 'O<Esc>', { desc = 'above' })

-- telescope
bind('n', '<leader>tf', cmd(':Telescope find_files'), { desc = 'telescope find_files' })

bind('n', '<leader>tg', cmd(':Telescope live_grep'), { desc = 'telescope live_grep' })

-- harpoon
bind({ 'i', 'n' }, '<C-h><C-a>', cmd(':HarpoonAppend'), { desc = 'add buffer to harpoon' })
bind({ 'i', 'n' }, '<C-h><C-r>', cmd(':HarpoonRemove'), { desc = 'remove buffer from harpoon' })
bind({ 'i', 'n' }, '<C-h><C-s>', cmd(':HarpoonShow'), { desc = 'show harpoon list' })
bind({ 'i', 'n' }, '<C-k>', cmd(':HarpoonPrev'), { desc = 'jump to previous harpooned buffer' })
bind({ 'i', 'n' }, '<C-j>', cmd(':HarpoonNext'), { desc = 'jump to next harpooned buffer' })

bind({ 'i', 'n' }, '<C-h>1', cmd(':HarpoonSwitch 1'), { desc = 'jump to harpoon buffer 1' })
bind({ 'i', 'n' }, '<C-h>2', cmd(':HarpoonSwitch 2'), { desc = 'jump to harpoon buffer 2' })
bind({ 'i', 'n' }, '<C-h>3', cmd(':HarpoonSwitch 3'), { desc = 'jump to harpoon buffer 3' })
bind({ 'i', 'n' }, '<C-h>4', cmd(':HarpoonSwitch 4'), { desc = 'jump to harpoon buffer 4' })
bind({ 'i', 'n' }, '<C-h>5', cmd(':HarpoonSwitch 5'), { desc = 'jump to harpoon buffer 5' })
bind({ 'i', 'n' }, '<C-h>6', cmd(':HarpoonSwitch 6'), { desc = 'jump to harpoon buffer 6' })
bind({ 'i', 'n' }, '<C-h>7', cmd(':HarpoonSwitch 7'), { desc = 'jump to harpoon buffer 7' })
bind({ 'i', 'n' }, '<C-h>8', cmd(':HarpoonSwitch 8'), { desc = 'jump to harpoon buffer 8' })
bind({ 'i', 'n' }, '<C-h>9', cmd(':HarpoonSwitch 9'), { desc = 'jump to harpoon buffer 9' })

-- resize windows
bind('n', '<S-Up>', cmd(':res -1'), { desc = 'resize window' })
bind('n', '<S-Down>', cmd(':res +1'), { desc = 'resize window' })
bind('n', '<S-Left>', cmd(':vert res +1'), { desc = 'resize window' })
bind('n', '<S-Right>', cmd(':vert res -1'), { desc = 'resize window' })

-- diff / merge
bind('n', '<leader>dn', ']c', { desc = 'next diff' })
bind('n', '<leader>dp', '[c', { desc = 'prev diff' })
bind('n', '<leader>dg', cmd(':diffget'), { desc = 'use other change (two way diff)' })
bind('n', '<leader>dl', cmd(':diffget local'), { desc = 'use local change' })
bind('n', '<leader>dr', cmd(':diffget remote'), { desc = 'use change from remote' })

-- notes
bind({ 'i', 'n' }, '<C-g><C-n>', cmd(':GlobalNote'), { desc = 'open/close global notes' })
