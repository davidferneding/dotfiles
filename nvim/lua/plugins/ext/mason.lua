-- [nfnl] Compiled from fnl/plugins/ext/mason.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local mason = require("mason")
  return mason.setup()
end
local function _2_()
  local mason_lspconfig = require("mason-lspconfig")
  mason_lspconfig.setup({automatic_installation = true})
  local function _3_(server_name)
    local lspconfig = (require("lspconfig"))[server_name]
    return lspconfig.setup({})
  end
  return mason_lspconfig.setup_handlers({_3_})
end
return {{"williamboman/mason.nvim", version = "*", config = _1_, priority = 1000}, {"williamboman/mason-lspconfig.nvim", version = "*", config = _2_, priority = 999}}
