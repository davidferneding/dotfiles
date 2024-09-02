-- [nfnl] Compiled from fnl/plugins/ext/nvim-cmp-with-deps.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local cmp = require("cmp")
  local function _2_(args)
    local luasnip = require("luasnip")
    return luasnip.lsp_expand(args.body)
  end
  local function _3_(fallback)
    if cmp.visible() then
      local entry = cmp.get_selected_entry()
      if not entry then
        cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
      else
      end
      return cmp.confirm()
    else
      return fallback()
    end
  end
  cmp.setup({snippet = {expand = _2_}, window = {}, mapping = cmp.mapping.preset.insert({["<C-b>"] = cmp.mapping.scroll_docs(-4), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<C-BS>"] = cmp.mapping.abort(), ["<Tab>"] = cmp.mapping(_3_, {"i", "s", "c"})}), sources = cmp.config.sources({{name = "nvim_lsp", keyword_length = 1}, {name = "luasnip", keyword_length = 2}, {name = "buffer", keyword_length = 3}})})
  cmp.setup.filetype("gitcommit", {sources = cmp.config.sources({{name = "git"}}, {{name = "buffer"}})})
  cmp.setup.cmdline({"/", "?"}, {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "buffer"}}})
  cmp.setup.cmdline(":", {mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}})})
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  return cmp_nvim_lsp.default_capabilities()
end
return {{"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-buffer"}, {"hrsh7th/cmp-path"}, {"hrsh7th/cmp-cmdline"}, {"hrsh7th/nvim-cmp", config = _1_}}
