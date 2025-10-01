return {
    "catppuccin/nvim",
    version = "*",
    name = "catppuccin",
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme catppuccin-latte]])
    end
}
