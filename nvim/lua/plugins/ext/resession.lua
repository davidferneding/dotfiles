-- [nfnl] Compiled from fnl/plugins/ext/resession.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local resession = require("resession")
  resession.setup()
  vim.keymap.set("n", "<leader>ss", resession.save, {desc = "Save current session"})
  vim.keymap.set("n", "<leader>sl", resession.load, {desc = "Load saved session"})
  return vim.keymap.set("n", "<leader>sd", resession.delete, {desc = "Delete saved session"})
end
return {"stevearc/resession.nvim", config = _1_}
