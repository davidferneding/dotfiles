(fn merge-tables [tables]
  (let [merged {}]
    (each [_ tbl (ipairs tables)]
      (each [k v (pairs tbl)]
        (tset merged k v)))
    merged))

(local wezterm (require :wezterm))

(local config-style
       {:color_scheme "Catppuccin Mocha"
        :colors {:visual_bell "#e78284"}
        :font (wezterm.font "Monaspace Neon")
        ; comment style
        :font_rules [{:intensity :Normal
                      :italic true
                      :font (wezterm.font "Monaspace Radon" {:weight :Medium})}]
        :font_size 14
        :freetype_load_target :HorizontalLcd
        :harfbuzz_features [:calt
                            :liga
                            :dlig
                            :ss01
                            :ss02
                            :ss03
                            :ss04
                            :ss05
                            :ss06
                            :ss07
                            :ss08
                            :ss09]
        :enable_tab_bar false
        :window_padding {:left 0 :right 0 :top 0 :bottom 0}})

(local config-feel {:audible_bell :Disabled
                    :visual_bell {:fade_in_duration_ms 75
                                  :fade_out_duration_ms 75
                                  :target :CursorColor}})

(local config-functional {:send_composed_key_when_left_alt_is_pressed true})

(local config-values
       (merge-tables [config-style config-feel config-functional]))

(local config (wezterm.config_builder))
(each [key value (pairs config-values)]
  (tset config key value))

config
