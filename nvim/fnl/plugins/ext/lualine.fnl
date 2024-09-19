{1 :nvim-lualine/lualine.nvim
 :dependencies [:nvim-tree/nvim-web-devicons]
 :config (fn []
           (tset vim.o :laststatus 3)
           ;; Eviline config for lualine
           ;; Author: shadmansaleh
           ;; Credit: glepnir
           (local lualine (require :lualine))
           ;; Color table for highlights
           ;; stylua: ignore
           (local colors {:bg "#303446"
                          :itembg "#626880"
                          :fg "#c6d0f5"
                          :yellow "#e5c890"
                          :cyan "#99d1db"
                          :darkblue "#081633"
                          :green "#a6d189"
                          :orange "#ef9f76"
                          :violet "#a9a1e1"
                          :magenta "#f4b8e4"
                          :blue "#8caaee"
                          :red "#ec5f67"})
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
                  {:options {;; Disable sections and component separators
                             :component_separators ""
                             :section_separators ""
                             :theme {;; We are going to use lualine_c an lualine_x as left and
                                     ;; right section. Both are highlighted by c theme .  So we
                                     ;; are just setting default looks o statusline
                                     :normal {:c {:fg colors.fg :bg colors.bg}}
                                     :inactive {:c {:fg colors.fg
                                                    :bg colors.bg}}}}
                   :sections {;; these are to remove the defaults
                              :lualine_a {}
                              :lualine_b {}
                              :lualine_y {}
                              :lualine_z {}
                              ;; These will be filled later
                              :lualine_c {}
                              :lualine_x {}}
                   :inactive_sections {;; these are to remove the defaults
                                       :lualine_a {}
                                       :lualine_b {}
                                       :lualine_y {}
                                       :lualine_z {}
                                       :lualine_c {}
                                       :lualine_x {}}})
           ;; Inserts a component in lualine_c at left section

           (fn ins_left [component]
             (table.insert config.sections.lualine_c component))

           ;; Inserts a component in lualine_x at right section

           (fn ins_right [component]
             (table.insert config.sections.lualine_x component))

           ;; (ins_left {1 "this is a test █  ..."})
           (ins_left {;; mode component
                      1 (fn []
                          (.. " (" (vim.fn.mode) ")"))
                      :color (fn []
                               ;; auto change color according to neovims mode
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
                      :padding {:right 1}})
           (ins_left {;; filesize component
                      1 :filesize
                      :cond conditions.buffer_not_empty})
           (ins_left {1 :filename
                      :cond conditions.buffer_not_empty
                      :color {:fg colors.magenta :gui :bold}})
           (ins_left {1 :location})
           (ins_left {1 :progress :color {:fg colors.fg :gui :bold}})
           (ins_left {1 :diagnostics
                      :sources [:nvim_diagnostic]
                      :symbols {:error " " :warn " " :info " "}
                      :diagnostics_color {:color_error {:fg colors.red}
                                          :color_warn {:fg colors.yellow}
                                          :color_info {:fg colors.cyan}}})
           ;; Insert mid section. You can make any number of sections in neovim :)
           ;; for lualine it's any number greater then 2
           (ins_left {1 (fn [] "%=")})
           (ins_left {;; Lsp server name .
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
                      :icon " LSP:"
                      :color {:fg "#ffffff" :gui :bold}})
           ;; Add components to right sections
           (ins_right {1 "o:encoding"
                       ;; option component same as &encoding in viml
                       :fmt string.upper
                       ;; I'm not sure why it's upper case either ;)
                       :cond conditions.hide_in_width
                       :color {:fg colors.green :gui :bold}})
           (ins_right {1 :fileformat
                       :fmt string.upper
                       :icons_enabled false
                       ;; I think icons are cool but Eviline doesn't have them. sigh
                       :color {:fg colors.green :gui :bold}})
           (ins_right {1 :branch
                       :icon ""
                       :color {:fg colors.violet :gui :bold}})
           (ins_right {1 :diff
                       ;; Is it me or the symbol for modified us really weird
                       :symbols {:added " "
                                 :modified "󰝤 "
                                 :removed " "}
                       :diff_color {:added {:fg colors.green}
                                    :modified {:fg colors.orange}
                                    :removed {:fg colors.red}}
                       :cond conditions.hide_in_width})
           ;; Now don't forget to initialize lualine
           (lualine.setup config))}
