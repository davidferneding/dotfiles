return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        -- define functions to configure keybinds in keys.lua
        vim.api.nvim_create_user_command('HarpoonAppend', function()
            harpoon:list():add()
        end, {})

        vim.api.nvim_create_user_command('HarpoonRemove', function()
            harpoon:list():remove()
        end, {})

        vim.api.nvim_create_user_command('HarpoonShow', function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, {})

        vim.api.nvim_create_user_command('HarpoonSwitch', function(opts)
            harpoon:list():select(tonumber(opts.args))
        end, { nargs = 1 })

        vim.api.nvim_create_user_command('HarpoonNext', function()
            harpoon:list():next()
        end, {})

        vim.api.nvim_create_user_command('HarpoonPrev', function()
            harpoon:list():prev()
        end, {})
    end
}
