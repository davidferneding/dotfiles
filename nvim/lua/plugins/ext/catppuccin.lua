-- [nfnl] Compiled from fnl/plugins/ext/catppuccin.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local catppuccin = require("catppuccin")
  catppuccin.setup({flavour = "frappe", background = {light = "latte", dark = "mocha"}, transparent_background = true, dim_inactive = {shade = "dark", percentage = 0.15, enabled = false}, styles = {comments = {"italic"}, conditionals = {"italic"}, loops = {}, functions = {}, keywords = {}, strings = {}, variables = {}, numbers = {}, booleans = {}, properties = {}, types = {}, operators = {}}, color_overrides = {}, custom_highlights = {}, integrations = {cmp = true, gitsigns = true, nvimtree = true, treesitter = true, mini = {enabled = true, indentscope_color = ""}, notify = false}, term_colors = false, show_end_of_buffer = false, no_italic = false, no_bold = false, no_underline = false})
  return vim.cmd.colorscheme("catppuccin")
end
return {"catppuccin/nvim", version = "*", name = "catppuccin", config = _1_, priority = 1000}
