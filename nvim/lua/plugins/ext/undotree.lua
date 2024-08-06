-- [nfnl] Compiled from fnl/plugins/ext/undotree.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.g["undotree_WindowLayout"] = 4
  return nil
end
return {"mbbill/undotree", config = _1_, lazy = false}
