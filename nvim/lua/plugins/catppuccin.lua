return {
    "catppuccin/nvim",
    version = "*",
    name = "catppuccin",
    priority = 1000,
    config = function()
        local theme = require("current-theme")
        vim.cmd("colorscheme " .. theme.colorscheme)
    end
}
