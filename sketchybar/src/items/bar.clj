(ns items.bar
  "Bar appearance and global defaults - replaces the bash bar/defaults block."
  (:require [sketchybar.core :as sketchybar]
            [util.config :as config]))

(def ^:private font "SF Pro")
(def ^:private paddings 3)

(def ^:private bar-props
  {:height        28
   :color         "0x00000000"
   :border_width  2
   :border_color  "0x00000000"
   :shadow        "off"
   :position      "top"
   :sticky        "on"
   :padding_right 10
   :padding_left  10
   :y_offset      2
   :notch_offset  5
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
   :background.height    28
   :background.corner_radius 9
   :background.border_width  2
   :popup.background.border_width  2
   :popup.background.corner_radius 9
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
