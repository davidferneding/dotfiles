{1 :nvim-lualine/lualine.nvim
 :dependencies [:nvim-tree/nvim-web-devicons]
 :config (fn []
           (tset vim.o :laststatus 3)
           (local lualine (require :lualine))
           (local catppuccin (require :catppuccin.palettes))
           (local colors (catppuccin.get_palette :frappe))
           (local conditions
                  {:buffer_not_empty (fn []
                                       (not= (vim.fn.empty (vim.fn.expand "%:t"))
                                             1))
                   :hide_in_width (fn []
                                    (> (vim.fn.winwidth 0) 80))
                   :check_git_workspace (fn []
                                          (local filepath
                                                 (vim.fn.expand "%:p:h"))
                                          (local gitdir
                                                 (vim.fn.finddir :.git
                                                                 (.. filepath
                                                                     ";")))
                                          (and (gitdir) (> #gitdir 0)
                                               (< #gitdir #filepath)))})
           ;; Config
           (local config
                  {:options {:component_separators "·"
                             :section_separators ""
                             :theme {:normal {:c {:fg colors.text}}
                                     :inactive {:c {:fg colors.text}}}}
                   :sections {:lualine_a {}
                              :lualine_b {}
                              :lualine_y {}
                              :lualine_z {}
                              :lualine_c {}
                              :lualine_x {}}
                   :inactive_sections {:lualine_a {}
                                       :lualine_b {}
                                       :lualine_y {}
                                       :lualine_z {}
                                       :lualine_c {}
                                       :lualine_x {}}})

           (fn insert-left [component]
             (table.insert config.sections.lualine_c component))

           (fn insert-right [component]
             (table.insert config.sections.lualine_x component))

           ;; left section
           (insert-left {;; mode
                         1 (fn []
                             (.. "(" (vim.fn.mode) ")"))
                         :color (fn []
                                  (local mode_color
                                         {:n colors.red
                                          :i colors.green
                                          :v colors.blue
                                          "␖" colors.blue
                                          :V colors.blue
                                          :c colors.pink
                                          :no colors.red
                                          :s colors.peach
                                          :S colors.peach
                                          "␓" colors.peach
                                          :ic colors.yellow
                                          :R colors.lavender
                                          :Rv colors.lavender
                                          :cv colors.red
                                          :ce colors.red
                                          :r colors.teal
                                          :rm colors.teal
                                          :r? colors.teal
                                          :! colors.red
                                          :t colors.red})
                                  {:fg (?. mode_color (vim.fn.mode))})
                         :padding {:left 1 :right 1}})
           (insert-left {;; filename
                         1 :filename
                         :cond conditions.buffer_not_empty
                         :color {:fg colors.maroon :gui :bold}})
           (insert-left {;; diagnostics
                         1 :diagnostics
                         :sources [:nvim_diagnostic]
                         :symbols {:error " " :warn " " :info " "}
                         :diagnostics_color {:color_error {:fg colors.red}
                                             :color_warn {:fg colors.yellow}
                                             :color_info {:fg colors.sky}}})
           ;; right section
           (insert-right {;; Lsp name
                          1 (fn []
                              (local msg "No Active Lsp")
                              (local buf_ft
                                     (vim.api.nvim_buf_get_option 0 :filetype))
                              (local clients (vim.lsp.get_clients))

                              (fn first-with-filetype [filetype list index]
                                (let [(i value) (next list index)]
                                  (if (= i nil) nil
                                      (let [filetypes value.config.filetypes]
                                        (if (and filetypes
                                                 (not= (vim.fn.index filetypes
                                                                     filetype)
                                                       -1))
                                            value.name
                                            (first-with-filetype filetype list
                                                                 i))))))

                              (local client
                                     (first-with-filetype buf_ft clients))
                              (if (= client nil) msg client))
                          :color {:fg "#ffffff" :gui :bold}})
           (insert-right {;; encoding
                          1 "o:encoding"
                          :fmt string.lower
                          :cond conditions.hide_in_width
                          :color {:fg colors.sapphire :gui :bold}})
           (insert-right {;; filesize
                          1 :filesize
                          :cond conditions.buffer_not_empty
                          :color {:fg colors.peach}})
           (insert-right {;; line endings
                          1 :fileformat
                          :fmt string.lower
                          :icons_enabled true
                          :color {:fg colors.mauve :gui :bold}})
           (insert-right {;; git branch
                          1 :branch
                          :color {:fg colors.teal :gui :bold}})
           (insert-right {1 :diff
                          :symbols {:added " "
                                    :modified " "
                                    :removed " "}
                          :diff_color {:added {:fg colors.green}
                                       :modified {:fg colors.orange}
                                       :removed {:fg colors.red}}
                          :cond conditions.hide_in_width})
           (lualine.setup config))}
