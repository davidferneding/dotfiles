--   ___       _   _
--  / _ \ _ __| |_(_)___ _ _  ___
-- | (_) | '_ \  _| / _ \ ' \(_-<
--  \___/| .__/\__|_\___/_||_/__/
--       |_|
-- info column
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.g.netrw_bufsettings = 'noma nomod nu relativenumber nowrap ro nobl'

-- highlighting
vim.opt.syntax = 'ON'
vim.opt.termguicolors = true
vim.g.t_co = 256
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#7777aa' })
vim.opt.cursorline = true

-- ui
vim.o.winborder = 'rounded'
vim.o.cmdheight = 0

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.autoindent = true

-- splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

-- encoding
vim.opt.bomb = false

-- spellcheck
vim.opt.spelllang = { 'en_gb', 'de_20' }
vim.opt.spell = true

-- lsp
vim.lsp.inlay_hint.enable(true)

-- persist undo
vim.opt.undodir = vim.fn.stdpath('cache') .. '/undo'
vim.opt.undofile = true

-- misc
vim.opt.scrolloff = 7
vim.opt.sidescrolloff = 7

-- map missing file types
vim.filetype.add({ extension = { mjml = 'html' } })


--  _  __
-- | |/ /___ _  _ _ __  __ _ _ __
-- | ' </ -_) || | '  \/ _` | '_ \
-- |_|\_\___|\_, |_|_|_\__,_| .__/
--           |__/           |_|
local key = vim.keymap
local function cmd(command)
    return "<cmd>" .. command .. "<cr>"
end


-- general
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
key.set("v", "<leader>y", "\"*y", { desc = "Yank to system clipboard" })

-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        key.set("n", "<leader>ff", vim.lsp.buf.format, { desc = "Format document" })
        key.set("v", "<leader>ff", vim.lsp.buf.format, { desc = "Format selection" })
        key.set("n", "gd", cmd("lua vim.lsp.buf.definition()"), { desc = "Go to definition" })
        key.set("n", "gD", cmd("lua vim.lsp.buf.declaration()"), { desc = "Go to declaration" })
        key.set("n", "<leader>i", cmd("lua vim.lsp.buf.hover()"), { desc = "Lsp hover" })
        key.set("n", "<leader>d", cmd("lua vim.diagnostic.open_float()"), { desc = "Show diagnostics" })
    end
})

-- resize
key.set("n", "<S-Up>", cmd("res -1"))
key.set("n", "<S-Down>", cmd("res +1"))
key.set("n", "<S-Left>", cmd("vert res +1"))
key.set("n", "<S-Right>", cmd("vert res -1"))



--  ___ _           _
-- | _ \ |_  _ __ _(_)_ _  ___
-- |  _/ | || / _` | | ' \(_-<
-- |_| |_|\_,_\__, |_|_||_/__/
--            |___/
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out,                            'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    checker = { enabled = true },
})
