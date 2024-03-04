-- LEADER
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- REMAPPINGS
local bind = vim.keymap.set
bind('i', '<leader><leader>', '<leader>', { desc = 'write <leader>' })

local cmd = function(command)
    return '<cmd>' .. command .. '<cr>'
end

-- saving / reloading
bind({ 'i', 'n' }, '<leader>sf', cmd(':w'), { desc = 'save file' })
bind({ 'i', 'n' }, '<leader>sc', cmd(':w') .. cmd(':bdelete') .. cmd(':bprevious'), { desc = 'save file and close' })
bind({ 'i', 'n' }, '<leader>sa', cmd(':wa'), { desc = 'save all' })
bind({ 'i', 'n' }, '<leader>sq', cmd(':xa'), { desc = 'save all and quit' })
bind({ 'i', 'n' }, '<leader>qq', cmd(':qa'), { desc = 'quit without saving' })
bind({ 'i', 'n' }, '<leader>rf', cmd(':w') .. cmd(':luafile %'), { desc = 'save and reload lua file' })

-- lsp
local lspbuf = vim.lsp.buf
bind('n', '<leader>jd', lspbuf.definition, { desc = 'jump to definition' })
bind('n', '<leader>ji', lspbuf.implementation, { desc = 'jump to implementation' })
bind('n', '<leader>jc', lspbuf.incoming_calls, { desc = 'jump to incoming calls' })
bind('n', '<leader>jr', lspbuf.references, { desc = 'jump to references' })
bind({ 'i', 'n' }, '<leader>si', lspbuf.hover, { desc = 'show hover information' })
bind({ 'i', 'n' }, '<leader>sa', lspbuf.code_action, { desc = 'show code actions' })
bind({ 'i', 'n' }, '<leader>rn', lspbuf.rename, { desc = 'rename' })
bind('n', '<leader>ff', lspbuf.format, { desc = 'format file' })
bind('v', '<leader>ff', lspbuf.format, { desc = 'format range' })

-- system clipboard
bind({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'copy to system clipboard' })
bind('n', '<leader>Y', '"+yg_', { desc = 'copy to system clipboard' })

-- nvim-tree
bind('i', '<leader>ts', '<esc>' .. cmd(':NvimTreeFocus'), { desc = 'focus file tree' })
bind('n', '<leader>ts', cmd(':NvimTreeFocus'), { desc = 'focus file tree' })
bind({ 'i', 'n' }, '<leader>th', cmd(':NvimTreeClose'), { desc = 'hide tree' })

-- new lines without leaving normal mode
bind('n', '<leader>o', 'o<Esc>', { desc = 'below' })
bind('n', '<leader>O', 'O<Esc>', { desc = 'above' })

-- search
bind({ 'i', 'n' }, '<leader>clh', cmd(':noh'), { desc = 'clear highlight' })

-- telescope
bind({ 'i', 'n' }, '<leader>tf', cmd(':Telescope find_files'), { desc = 'telescope find_files' })
bind({ 'i', 'n' }, '<leader>tg', cmd(':Telescope live_grep'), { desc = 'telescope live_grep' })

-- mason
bind({ 'i', 'n' }, '<leader>lspu', cmd(':Mason'), { desc = 'update lsp config' })

-- harpoon
bind({ 'i', 'n' }, '<leader>ha', cmd(':HarpoonAppend'), { desc = 'add buffer to harpoon' })
bind({ 'i', 'n' }, '<leader>hr', cmd(':HarpoonRemove'), { desc = 'remove buffer from harpoon' })
bind({ 'i', 'n' }, '<leader>hs', cmd(':HarpoonShow'), { desc = 'show harpoon list' })
bind({ 'i', 'n' }, '<leader>hn', cmd(':HarpoonNext'), { desc = 'jump to next harpooned buffer' })
bind({ 'i', 'n' }, '<leader>hp', cmd(':HarpoonPrev'), { desc = 'jump to previous harpooned buffer' })

bind({ 'i', 'n' }, '<leader>h1', cmd(':HarpoonSwitch 1'), { desc = 'jump to harpoon buffer 1' })
bind({ 'i', 'n' }, '<leader>h2', cmd(':HarpoonSwitch 2'), { desc = 'jump to harpoon buffer 2' })
bind({ 'i', 'n' }, '<leader>h3', cmd(':HarpoonSwitch 3'), { desc = 'jump to harpoon buffer 3' })
bind({ 'i', 'n' }, '<leader>h4', cmd(':HarpoonSwitch 4'), { desc = 'jump to harpoon buffer 4' })
bind({ 'i', 'n' }, '<leader>h5', cmd(':HarpoonSwitch 5'), { desc = 'jump to harpoon buffer 5' })
bind({ 'i', 'n' }, '<leader>h6', cmd(':HarpoonSwitch 6'), { desc = 'jump to harpoon buffer 6' })
bind({ 'i', 'n' }, '<leader>h7', cmd(':HarpoonSwitch 7'), { desc = 'jump to harpoon buffer 7' })
bind({ 'i', 'n' }, '<leader>h8', cmd(':HarpoonSwitch 8'), { desc = 'jump to harpoon buffer 8' })
bind({ 'i', 'n' }, '<leader>h9', cmd(':HarpoonSwitch 9'), { desc = 'jump to harpoon buffer 9' })

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
bind({ 'i', 'n' }, '<leader>gn', cmd(':GlobalNote'), { desc = 'open/close global notes' })
