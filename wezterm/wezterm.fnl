(fn merge-tables [tables]
  (let [merged {}]
    (each [_ tbl (ipairs tables)]
      (each [k v (pairs tbl)]
        (tset merged k v)))
    merged))

(local wezterm (require :wezterm))

(local config (wezterm.config_builder))

(local config-style
       {:color_scheme "Catppuccin Macchiato"
        :font (wezterm.font "VictorMono Nerd Font" {:weight :Regular})
        :font_size 15
        :enable_tab_bar false
        :window_padding {:left 0 :right 0 :top 0 :bottom 0}})

(local config-functional {:send_composed_key_when_left_alt_is_pressed true})

(local config-values (merge-tables [config-style config-functional]))

(each [key value (pairs config-values)]
  (tset config key value))

config
