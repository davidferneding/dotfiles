(ns config)

(def colors {:bg 0x99414559
             :text-light 0xffc6d0f5
             :text-dark 0xff4c4f69

             :red 0xffe78284})

(def item {:background.drawing "on"
           :background.color (:bg colors)
           :blur_radius 20

           :padding_left 8
           :padding_right 8

           :label.padding_left 8
           :label.padding_right 8

           :icon.padding_left 8
           :icon.font "sketchybar-app-font:Regular:16.0"})

(def plugin-dir "~/.config/sketchybar/plugins")
