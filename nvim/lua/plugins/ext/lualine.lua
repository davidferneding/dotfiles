-- [nfnl] Compiled from fnl/plugins/ext/lualine.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local palette = require("catppuccin.macchiato")
  local palette_light = require("catppuccin.latte")
  local catppuccin_theme = {inactive = {a = {bg = palette.base.hex, fg = palette.text.hex}, b = {bg = palette.base.hex, fg = palette.text.hex}, c = {bg = palette.base.hex, fg = palette.text.hex}}, insert = {a = {bg = palette.rosewater.hex, fg = palette_light.text.hex}}, normal = {a = {bg = palette.lavender.hex, fg = palette_light.text.hex}, b = {bg = palette.peach.hex, fg = palette_light.text.hex}, c = {bg = palette.base.hex, fg = palette.text.hex}}, replace = {a = {bg = palette.maroon.hex, fg = palette_light.text.hex}}, visual = {a = {bg = palette.sapphire.hex, fg = palette_light.text.hex}}}
  local lualine = require("lualine")
  return lualine.setup({extensions = {}, inactive_sections = {lualine_a = {"filename"}, lualine_b = {}, lualine_c = {}, lualine_x = {}, lualine_y = {}, lualine_z = {"location"}}, options = {component_separators = "", theme = "auto", globalstatus = true}, sections = {lualine_a = {{"mode", right_padding = 8, separator = {left = "\238\130\182", right = "\238\130\180"}}}, lualine_b = {{"filename", right_padding = 8, separator = {left = "\238\130\182", right = "\238\130\180"}}}, lualine_c = {"branch", "diff", "diagnostics"}, lualine_x = {"encoding", "location"}, lualine_y = {{"progress", left_padding = 8, separator = {left = "\238\130\182", right = "\238\130\180"}}}, lualine_z = {{"filetype", left_padding = 8, separator = {left = "\238\130\182", right = "\238\130\180"}}}}, tabline = {}})
end
return {"nvim-lualine/lualine.nvim", dependencies = {"nvim-tree/nvim-web-devicons"}, config = _1_}
