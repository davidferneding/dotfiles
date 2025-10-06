return {
    {
        'stevearc/oil.nvim',
        opts = {
            float = { max_width = 0.4, max_height = 0.4 },
            view_options = { show_hidden = true },
        },
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        lazy = false,
        keys = {
            { "-", "<cmd>Oil --float<cr>", desc = "Toggle Oil" }
        }
    },
    {
        "JezerM/oil-lsp-diagnostics.nvim",
        dependencies = { "stevearc/oil.nvim" },
        opts = {}
    }
}
