-- [nfnl] Compiled from fnl/config/vars.fnl by https://github.com/Olical/nfnl, do not edit.
local function set_opt(key, value)
  vim.opt[key] = value
  return nil
end
local options = {number = true, relativenumber = true, signcolumn = "yes", syntax = "ON", termguicolors = true, ignorecase = true, smartcase = true, incsearch = true, hlsearch = true, expandtab = true, shiftwidth = 4, softtabstop = 4, tabstop = 4, splitright = true, splitbelow = true, scrolloff = 7}
for key, value in pairs(options) do
  set_opt(key, value)
end
vim.api.nvim_set_hl(0, "LineNr", {fg = "#7777aa"})
vim.g["netrw_bufsettings"] = "noma nomod nu relativenumber nowrap ro nobl"
vim.g["t_co"] = 256
return vim.filetype.add({extension = {mjml = "html"}})
