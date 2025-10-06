return {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '*',
    opts = {
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        keymap = { preset = 'super-tab' },
        appearance = {
            nerd_font_variant = 'mono'
        },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 100 },
            ghost_text = { enabled = true }
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "prefer_rust" },
        signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
}
