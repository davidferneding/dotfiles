{1 :nvim-treesitter/nvim-treesitter
 :version "*"
 :build ":TSUpdate"
 :config (fn []
           (local configs (require :nvim-treesitter.configs))
           (local config
                  {:ensure_installed :all
                   :sync_install false
                   :auto_install true
                   :ignore_install [:ipkg]
                   :highlight {:enable true
                               :additional_vim_regex_highlighting false}
                   :incremental_selection {:enable true
                                           :keymaps {:init_selection :<tab>
                                                     :node_incremental :<tab>
                                                     :node_decremental :<BS>}}
                   :refactor {:highlight_definitions {:enable true
                                                      :clear_on_cursor_move true}
                              :smart_rename {:enable true
                                             :keymaps {:smart_rename :<leader>rs}}
                              :navigation {:enable true
                                           :keymaps {;:goto_definition :<leader>jd
                                                     ;:list_definitions :<leader>ld
                                                     :list_definitions_toc :<leader>lc
                                                     :goto_next_usage :<leader>ju
                                                     :goto_previous_usage :<leader>ku}}}})
           (configs.setup config))}
