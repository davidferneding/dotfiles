-- [nfnl] Compiled from fnl/plugins/ext/noice.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local notify = require("notify")
  notify.setup({background_colour = "#6e738d"})
  local noice = require("noice")
  return noice.setup({cmdline = {view = "cmdline"}, lsp = {override = {[{"vim.lsp.util.convert_input_to_markdown_lines"}] = true, [{"vim.lsp.util.stylize_markdown"}] = true, [{"cmp.entry.get_documentation"}] = true}}, presets = {bottom_search = true, command_palette = true, long_message_to_split = true, lsp_doc_border = true, inc_rename = false}})
end
return {"folke/noice.nvim", version = "*", event = "VeryLazy", dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"}, config = _1_}
