return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-mini/mini.icons" },
    opts = {},
    keys = {
        { "<leader><leader>", "<cmd>FzfLua files<cr>",        desc = "Search files using fzf" },
        { "<leader>/",        "<cmd>FzfLua live_grep_native<cr>", desc = "Live grep project using fzf" },
        { "<leader>/",        "<cmd>FzfLua grep_visual<cr>",      mode = "v",                          desc = "Grep selection using fzf" },
        { "<leader>?",        "<cmd>FzfLua keymaps<cr>", desc = "Search through keymap" },
    },
}
