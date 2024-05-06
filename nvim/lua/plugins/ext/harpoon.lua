-- [nfnl] Compiled from fnl/plugins/ext/harpoon.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local harpoon = require("harpoon")
  harpoon:setup()
  local function _2_()
    local list = harpoon:list()
    return list:add()
  end
  vim.api.nvim_create_user_command("HarpoonAppend", _2_, {})
  local function _3_()
    local list = harpoon:list()
    return list:remove()
  end
  vim.api.nvim_create_user_command("HarpoonRemove", _3_, {})
  local function _4_()
    return (harpoon.ui):toggle_quick_menu(harpoon:list())
  end
  vim.api.nvim_create_user_command("HarpoonShow", _4_, {})
  local function _5_(opts)
    local list = harpoon:list()
    return list:select(tonumber(opts.args))
  end
  vim.api.nvim_create_user_command("HarpoonSwitch", _5_, {nargs = 1})
  local function _6_()
    local list = harpoon:list()
    return list:next()
  end
  vim.api.nvim_create_user_command("HarpoonNext", _6_, {})
  local function _7_()
    local list = harpoon:list()
    return list:prev()
  end
  return vim.api.nvim_create_user_command("HarpoonPrev", _7_, {})
end
return {"ThePrimeagen/harpoon", branch = "harpoon2", dependencies = {"nvim-lua/plenary.nvim"}, config = _1_}
