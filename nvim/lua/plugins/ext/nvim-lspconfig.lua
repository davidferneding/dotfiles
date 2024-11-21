-- [nfnl] Compiled from fnl/plugins/ext/nvim-lspconfig.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local cmp = require("cmp_nvim_lsp")
  local capabilities = cmp.default_capabilities()
  local lspconfig = require("lspconfig")
  return lspconfig.omnisharp.setup({capabilities = capabilities, enable_roslyn_analysers = true, enable_import_completion = true, organize_imports_on_format = true, filetypes = {"cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets"}})
end
return {"neovim/nvim-lspconfig", version = "*", config = _1_}
