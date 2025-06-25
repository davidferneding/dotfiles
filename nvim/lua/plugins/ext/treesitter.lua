-- [nfnl] fnl/plugins/ext/treesitter.fnl
local function _1_()
  local configs = require("nvim-treesitter.configs")
  local config = {ensure_installed = "all", auto_install = true, ignore_install = {"ipkg"}, highlight = {enable = true, additional_vim_regex_highlighting = false}, incremental_selection = {enable = true, keymaps = {init_selection = "<tab>", node_incremental = "<tab>", node_decremental = "<BS>"}}, refactor = {highlight_definitions = {enable = true, clear_on_cursor_move = true}, smart_rename = {enable = true, keymaps = {smart_rename = "<leader>rs"}}, navigation = {enable = true, keymaps = {list_definitions_toc = "<leader>lc", goto_next_usage = "<leader>ju", goto_previous_usage = "<leader>ku"}}}, sync_install = false}
  return configs.setup(config)
end
return {"nvim-treesitter/nvim-treesitter", version = "*", build = ":TSUpdate", config = _1_}
