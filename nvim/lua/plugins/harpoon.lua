return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
        { "<leader>a", function() harpoon:list():add() end,                         desc = "Add to harpoon list" },
        { "<C-h>",     function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Toggle harpoon list" },
        { "<C-S-h>",   function() harpoon:list():prev() end,                        desc = "Go to previous harpoon buffer" },
        { "<C-S-s>",   function() harpoon:list():next() end,                        desc = "Go to next harpoon buffer" },
    },
}
