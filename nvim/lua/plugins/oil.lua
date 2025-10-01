return {
    {
        'stevearc/oil.nvim',
        opts = { float = { max_width = 0.4, max_height = 0.4 } },
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        lazy = false,
        keys = {
            { "-", "<cmd>Oil --float<cr>", desc = "Toggle Oil" }
        }
    },
    {
        "benomahony/oil-git.nvim",
        dependencies = { "stevearc/oil.nvim" },
        opts ={highlights={OilGitModified={fg="#df8e1d"}}}
    }
}
