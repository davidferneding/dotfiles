require('mini.move').setup({
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
    left = '',
    right = '',
    down = '<C-S-down>',
    up = '<C-S-up>',

    -- Move current line in Normal mode
    line_left = '',
    line_right = '',
    line_down = '<C-S-down>',
    line_up = '<C-S-up>',
  },

  -- Options which control moving behavior
  options = {
    -- Automatically reindent selection during linewise vertical move
    reindent_linewise = true,
  },
})

require('mini.pairs').setup()
