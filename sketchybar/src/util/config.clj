(ns util.config
  (:require [clojure.edn :as edn]
            [clojure.java.io :as io]))

(def colors
  (edn/read-string (slurp (io/resource "theme_colors.edn"))))

(def custom-icons
  (edn/read-string (slurp (io/resource "custom_icons.edn"))))

(def icon-map
  (edn/read-string (slurp (io/resource "icon_map.edn"))))

(defn icon-font [& {:keys [weight size]
                     :or {weight "Regular" size 16.0}}]
  (str "sketchybar-app-font:" weight ":" size))

(defn label-font [& {:keys [weight size]
                      :or {weight "Medium" size 16.0}}]
  (str "Monaspace Neon:" weight ":" size))

(def item-defaults
  {:background.drawing "on"
   :background.color   (:bg colors)
   :blur_radius        0

   :padding_left       8
   :padding_right      8

   :label              "loading"
   :label.font         (label-font)
   :label.padding_left  4
   :label.padding_right 8
   :label.shadow.drawing "off"

   :icon.padding_left  8
   :icon.font          (icon-font)

   :updates            "on"})

