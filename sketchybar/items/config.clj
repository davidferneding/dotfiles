(ns config
  (:require [clojure.edn :as edn]))

(defn icon-font [& {:keys [weight size]
                    :or {weight "Regular" size 16.0}}]
  (str "sketchybar-app-font:" weight ":" size))

(defn label-font [& {:keys [weight size]
                     :or {weight "Semibold" size 15.0}}]
  (str "Victor Mono Nerd Font" ":" weight ":" size))

(def colors {:bg 0xff414559
             :text-light 0xffc6d0f5
             :text-dark 0xff4c4f69

             :red 0xffe78284})

(def item {:background.drawing "on"
           :background.color (:bg colors)
           :blur_radius 20

           :padding_left 8
           :padding_right 8

           :label "loading"
           :label.font (label-font)
           :label.padding_left 4
           :label.padding_right 8

           :icon.padding_left 8
           :icon.font (icon-font)

           :updates "on"})

(def plugin-dir (str (System/getProperty "user.home") "/.config/sketchybar/plugins"))

(def icon-map (edn/read-string (slurp (str (System/getProperty "user.home") "/.config/sketchybar/icon_map.edn"))))
(def custom-icons (edn/read-string (slurp (str (System/getProperty "user.home") "/.config/sketchybar/custom_icons.edn"))))
