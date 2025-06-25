-- [nfnl] fnl/plugins/ext/mason.fnl
return {"mason-org/mason-lspconfig.nvim", version = "*", dependencies = {{"mason-org/mason.nvim", version = "*", opts = {}}, {"neovim/nvim-lspconfig"}}, opts = {ensure_installed = {"lua_ls"}}}
