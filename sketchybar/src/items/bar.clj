(ns items.bar
  "Bar appearance and global defaults - replaces the bash bar/defaults block."
  (:require [sketchybar.core :as sketchybar]
            [util.config :as config]))

(def ^:private font "SF Pro")
(def ^:private paddings 4)

(def ^:private bar-props
  {:height        32
   :color         "0x00000000"
   :border_width  0
   :border_color  "0x00000000"
   :shadow        "off"
   :position      "top"
   :sticky        "on"
   :padding_right 8
   :padding_left  8
   :y_offset      1
   :notch_offset  2
   :topmost       "window"})

(def ^:private default-props
  {:updates              "when_shown"
   :icon.font            (str font ":Regular:14.0")
   :icon.color           (:text-light config/colors)
   :icon.padding_left    paddings
   :icon.padding_right   paddings
   :label.font           (str font ":Semibold:13.0")
   :label.color          (:text-light config/colors)
   :label.padding_left   paddings
   :label.padding_right  paddings
   :label.shadow.drawing "on"
   :label.shadow.distance 2
   :label.shadow.color   "0xff000000"
   :padding_right        paddings
   :padding_left         paddings
   :background.height    26
   :background.corner_radius 8
   :background.border_width  0
   :popup.background.border_width  0
   :popup.background.corner_radius 8
   :popup.background.border_color  (:text-light config/colors)
   :popup.background.color         (:bg config/colors)
   :popup.blur_radius              20
   :popup.background.shadow.drawing "on"
   :scroll_texts         "on"})

(defn setup []
  (sketchybar/exec
   (sketchybar/bar bar-props)
   (sketchybar/default default-props)))

(defn -main [& _args]
  (setup))
