return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
        { "<leader>a", function() require("harpoon"):list():add() end,                                    desc = "Add to harpoon list" },
        { "<leader>r", function() require("harpoon"):list():remove() end,                                 desc = "Remove from harpoon list" },
        { "<C-h>",     function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Toggle harpoon list" },
        { "<leader>h", function() require("harpoon"):list():prev({ ui_nav_wrap = true }) end,             desc = "Go to previous harpoon buffer" },
        { "<leader>s", function() require("harpoon"):list():next({ ui_nav_wrap = true }) end,             desc = "Go to next harpoon buffer" },
    },
}
