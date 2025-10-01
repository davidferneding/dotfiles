return {
    { 'mason-org/mason.nvim', opts = {} },
    {
        'mason-org/mason-lspconfig.nvim',
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
