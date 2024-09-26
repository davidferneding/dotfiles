{1 :nvim-lualine/lualine.nvim
 :dependencies [:nvim-tree/nvim-web-devicons]
 :config (fn []
           (local palette (require :catppuccin.macchiato))
           (local palette-light (require :catppuccin.latte))
           (local catppuccin-theme
                  {:inactive {:a {:bg palette.base.hex :fg palette.text.hex}
                              :b {:bg palette.base.hex :fg palette.text.hex}
                              :c {:bg palette.base.hex :fg palette.text.hex}}
                   :insert {:a {:bg palette.rosewater.hex
                                :fg palette-light.text.hex}}
                   :normal {:a {:bg palette.lavender.hex
                                :fg palette-light.text.hex}
                            :b {:bg palette.peach.hex
                                :fg palette-light.text.hex}
                            :c {:bg palette.base.hex :fg palette.text.hex}}
                   :replace {:a {:bg palette.maroon.hex
                                 :fg palette-light.text.hex}}
                   :visual {:a {:bg palette.sapphire.hex
                                :fg palette-light.text.hex}}})
           (local lualine (require :lualine))
           (lualine.setup {:extensions {}
                           :inactive_sections {:lualine_a [:filename]
                                               :lualine_b {}
                                               :lualine_c {}
                                               :lualine_x {}
                                               :lualine_y {}
                                               :lualine_z [:location]}
                           :options {:component_separators ""
                                     ;;:section_separators {:left ""
                                     ;;                     :right ""}
                                     :theme :auto
                                     ;; ccatppuccin-theme
                                     :globalstatus true}
                           :sections {:lualine_a [{1 :mode
                                                   :right_padding 8
                                                   :separator {:left ""
                                                               :right ""}}]
                                      :lualine_b [{1 :filename
                                                   :right_padding 8
                                                   :separator {:left ""
                                                               :right ""}}]
                                      :lualine_c [:branch :diff :diagnostics]
                                      :lualine_x [:encoding :location]
                                      :lualine_y [{1 :progress
                                                   :left_padding 8
                                                   :separator {:left ""
                                                               :right ""}}]
                                      :lualine_z [{1 :filetype
                                                   :left_padding 8
                                                   :separator {:left ""
                                                               :right ""}}]}
                           :tabline {}}))}
