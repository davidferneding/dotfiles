{1 :ThePrimeagen/harpoon
 :branch :harpoon2
 :dependencies [:nvim-lua/plenary.nvim]
 :config (fn []
           (local harpoon (require :harpoon))
           ;; REQUIRED
           (harpoon:setup {:settings {:save_on_toggle true}})
           ;; REQUIRED
           ;;
           ;; define functions to configure keybinds in keys.fnl
           (vim.api.nvim_create_user_command :HarpoonAppend
                                             (fn []
                                               (local list (harpoon:list))
                                               (list:add))
                                             {})
           (vim.api.nvim_create_user_command :HarpoonRemove
                                             (fn []
                                               (local list (harpoon:list))
                                               (list:remove))
                                             {})
           (vim.api.nvim_create_user_command :HarpoonShow
                                             (fn []
                                               (harpoon.ui:toggle_quick_menu (harpoon:list)))
                                             {})
           (vim.api.nvim_create_user_command :HarpoonSwitch
                                             (fn [opts]
                                               (local list (harpoon:list))
                                               (list:select (tonumber opts.args)))
                                             {:nargs 1})
           (vim.api.nvim_create_user_command :HarpoonNext
                                             (fn []
                                               (local list (harpoon:list))
                                               (list:next))
                                             {})
           (vim.api.nvim_create_user_command :HarpoonPrev
                                             (fn []
                                               (local list (harpoon:list))
                                               (list:prev))
                                             {}))}

