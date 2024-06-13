(local wezterm (require :wezterm))

(local config (wezterm.config_builder))

(local config-values
       {;; appearance
        :color_scheme "Catppuccin Frappe"
        :font (wezterm.font "VictorMono Nerd Font" {:weight :Regular})
        :font_size 15
        :enable_tab_bar false
        :window_padding {:left 0 :right 0 :top 0 :bottom 0}
        :send_composed_key_when_left_alt_is_pressed true})

;; test
(each [key value (pairs config-values)]
  (tset config key value))

(fn get [val] val)

(get config)

