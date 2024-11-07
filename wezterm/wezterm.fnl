(fn merge-tables [tables]
  (let [merged {}]
    (each [_ tbl (ipairs tables)]
      (each [k v (pairs tbl)]
        (tset merged k v)))
    merged))

(local wezterm (require :wezterm))

(local config-style
       {:color_scheme "Catppuccin Frappe"
        :colors {:visual_bell "#e78284"}
        :font (wezterm.font "VictorMono Nerd Font" {:weight :Regular})
        :font_size 15
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
