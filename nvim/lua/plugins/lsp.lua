return {
    {
        'mason-org/mason.nvim',
        version = "*",
        opts = {},
    },
    {
        'mason-org/mason-lspconfig.nvim',
        version = "*",
        dependencies = { 'neovim/nvim-lspconfig' },
        opts = {
            ensure_installed = {
                "lua_ls",
                "clojure_lsp",
                "pylsp",
                "ts_ls",
                "fennel_language_server",
            }
        },
        init = function()
            vim.lsp.enable({ "roslyn_ls" })
        end,
    },
}
