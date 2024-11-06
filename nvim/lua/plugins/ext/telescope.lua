-- [nfnl] Compiled from fnl/plugins/ext/telescope.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local telescope = require("telescope")
  telescope.load_extension("noice")
  local actions = require("telescope.actions")
  local config = {defaults = {mappings = {i = {["<esc>"] = actions.close}}}}
  return telescope.setup(config)
end
return {"nvim-telescope/telescope.nvim", version = "*", dependencies = {"nvim-lua/plenary.nvim"}, config = _1_}
