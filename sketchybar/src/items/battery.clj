(ns items.battery
  (:require [sketchybar.core :as sketchybar]
            [taoensso.timbre :as log]
            [util.config :as config]
            [util.helpers :as helpers]))

(defn setup []
  (log/debug "setting up item battery")
  (sketchybar/exec
   (sketchybar/add-item :battery :right)
   (sketchybar/set :battery (merge config/item-defaults
                                   {:label              "loading"
                                    :label.padding_left -2
                                    :icon               (:sync (:battery config/custom-icons))
                                    :icon.font          (config/label-font :weight "Bold" :size 18.0)
                                    :icon.y_offset      1
                                    :icon.padding_right 8
                                    :script             (helpers/plugin-cmd 'plugins.battery)
                                    :click_script       (helpers/plugin-cmd 'plugins.battery-click)
                                    :update_freq        60}))
   (sketchybar/subscribe :battery :power_source_change)))

(defn -main [& _args]
  (setup))
