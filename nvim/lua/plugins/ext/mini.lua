return {
    {
        'echasnovski/mini.move',
        version = '*',
        opts = {
            -- Module mappings. Use `''` (empty string) to disable one.
            mappings = {
                -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                left = '<left>',
                right = '<right>',
                down = '<down>',
                up = '<up>',

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
        }
    },
    {
        'echasnovski/mini.pairs',
        version = '*',
        opts = {}
    },
}
