-- [nfnl] Compiled from fnl/plugins/ext/autolist.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local autolist = require("autolist")
  autolist.setup()
  vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
  vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
  vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
  vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
  vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
  vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
  vim.keymap.set("n", "<leader>lr", "<cmd>AutolistRecalculate<cr>")
  vim.keymap.set("n", "<leader>ltn", autolist.cycle_next_dr, {expr = true})
  vim.keymap.set("n", "<leader>ltp", autolist.cycle_prev_dr, {expr = true})
  vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
  vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
  vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
  return vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
end
return {"gaoDean/autolist.nvim", version = "*", ft = {"markdown", "text", "tex", "plaintex", "norg"}, config = _1_}
