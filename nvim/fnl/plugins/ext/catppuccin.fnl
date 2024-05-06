{1 :catppuccin/nvim
 :version "*"
 :name :catppuccin
 :config (fn []
           (local catppuccin (require :catppuccin))
           (catppuccin.setup {;; latte, frappe, macchiato, mocha
                              :flavour :frappe
                              :background {;; :h background
                                           :light :latte
                                           :dark :mocha}
                              ;; disables setting the background color.
                              :transparent_background true
                              ;; shows the '~' characters after the end of buffers
                              :show_end_of_buffer false
                              ;; sets terminal colors (e.g. `g:terminal_color_0`)
                              :term_colors false
                              :dim_inactive {;; dims the background color of inactive window
                                             :enabled false
                                             :shade :dark
                                             ;; percentage of the shade to apply to the inactive window
                                             :percentage 0.15}
                              ;; Force no italic
                              :no_italic false
                              ;; Force no bold
                              :no_bold false
                              ;; Force no underline
                              :no_underline false
                              :styles {;; Handles the styles of general hi groups (see `:h highlight-args`):
                                       ;; Change the style of comments
                                       :comments [:italic]
                                       :conditionals [:italic]
                                       :loops []
                                       :functions []
                                       :keywords []
                                       :strings []
                                       :variables []
                                       :numbers []
                                       :booleans []
                                       :properties []
                                       :types []
                                       :operators []}
                              :color_overrides {}
                              :custom_highlights {}
                              :integrations {:cmp true
                                             :gitsigns true
                                             :nvimtree true
                                             :treesitter true
                                             :notify false
                                             :mini {:enabled true
                                                    :indentscope_color ""}
                                             ;; For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                                             }})
           ;; setup must be called before loading
           (vim.cmd.colorscheme :catppuccin))
 :priority 1000}

