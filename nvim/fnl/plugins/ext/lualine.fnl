{1 :nvim-lualine/lualine.nvim
 :dependencies [:nvim-tree/nvim-web-devicons]
 :config (fn []
           (tset vim.o :laststatus 3)
           (local lualine (require :lualine))
           (local palette (require :catppuccin.frappe))
           (local colors {:fg palette.text.hex
                          :yellow palette.yellow.hex
                          :cyan palette.teal.hex
                          :darkblue palette.lavender.hex
                          :green palette.green.hex
                          :orange palette.peach.hex
                          :violet palette.mauve.hex
                          :magenta palette.pink.hex
                          :blue palette.blue.hex
                          :red palette.red.hex})
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
                             :theme {:normal {:c {:fg colors.fg :bg colors.bg}}
                                     :inactive {:c {:fg colors.fg
                                                    :bg colors.bg}}}}
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

           (fn ins_left [component]
             "Inserts a component to the left section of the line"
             (table.insert config.sections.lualine_c component))

           (fn ins_right [component]
             "Inserts a ccomponent to the right section of the line"
             (table.insert config.sections.lualine_x component))

           ;; left section
           (ins_left {;; mode
                      1 (fn []
                          (.. " (" (vim.fn.mode) ")"))
                      :color (fn []
                               (local mode_color
                                      {:n colors.red
                                       :i colors.green
                                       :v colors.blue
                                       "␖" colors.blue
                                       :V colors.blue
                                       :c colors.magenta
                                       :no colors.red
                                       :s colors.orange
                                       :S colors.orange
                                       "␓" colors.orange
                                       :ic colors.yellow
                                       :R colors.violet
                                       :Rv colors.violet
                                       :cv colors.red
                                       :ce colors.red
                                       :r colors.cyan
                                       :rm colors.cyan
                                       :r? colors.cyan
                                       :! colors.red
                                       :t colors.red})
                               {:fg (?. mode_color (vim.fn.mode))})
                      :padding {:left 1 :right 1}})
           (ins_left {;; filename
                      1 :filename
                      :icon "󰈙"
                      :cond conditions.buffer_not_empty
                      :color {:fg colors.magenta :gui :bold}})
           (ins_left {;; diagnostics
                      1 :diagnostics
                      :sources [:nvim_diagnostic]
                      :symbols {:error " " :warn " " :info " "}
                      :diagnostics_color {:color_error {:fg colors.red}
                                          :color_warn {:fg colors.yellow}
                                          :color_info {:fg colors.cyan}}})
           ;; right section
           (ins_right {;; Lsp name
                       1 (fn []
                           (local msg "No Active Lsp")
                           (local buf_ft
                                  (vim.api.nvim_buf_get_option 0 :filetype))
                           (local clients (vim.lsp.get_active_clients))

                           (fn first-with-filetype [filetype list index]
                             (let [(i value) (next list index)]
                               (if (= i nil) nil
                                   (let [filetypes value.config.filetypes]
                                     (if (and filetypes
                                              (not= (vim.fn.index filetypes
                                                                  filetype)
                                                    -1))
                                         value.name
                                         (first-with-filetype filetype list i))))))

                           (local client (first-with-filetype buf_ft clients))
                           (if (= client nil) msg client))
                       :icon ""
                       :color {:fg "#ffffff" :gui :bold}})
           (ins_right {;; encoding
                       1 "o:encoding"
                       :fmt string.lower
                       :icon ""
                       :cond conditions.hide_in_width
                       :color {:fg colors.green :gui :bold}})
           (ins_right {;; filesize
                       1 :filesize
                       :icon "󰖡"
                       :cond conditions.buffer_not_empty})
           (ins_right {;; line endings
                       1 :fileformat
                       :fmt string.lower
                       :icons_enabled true
                       :color {:fg colors.violet :gui :bold}})
           (ins_right {;; git branch
                       1 :branch
                       :icon ""
                       :color {:fg colors.cyan :gui :bold}})
           (ins_right {1 :diff
                       :symbols {:added " "
                                 :modified " "
                                 :removed " "}
                       :diff_color {:added {:fg colors.green}
                                    :modified {:fg colors.orange}
                                    :removed {:fg colors.red}}
                       :cond conditions.hide_in_width})
           (lualine.setup config))}
