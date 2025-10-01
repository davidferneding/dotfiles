return {
    "sindrets/diffview.nvim",
    keys = {
        { "<leader>dn", "]c",                      desc = "Jump to next diff" },
        { "<leader>dp", "[c",                      desc = "Jump to previous diff" },
        { "<leader>dg", "<cmd>diffget<cr>",        desc = "Use other change (two way diff)" },
        { "<leader>dl", "<cmd>diffget local<cr>",  desc = "Use local change" },
        { "<leader>dr", "<cmd>diffget remote<cr>", desc = "Use remote change" },
    }
}
