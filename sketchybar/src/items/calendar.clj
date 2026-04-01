(ns items.calendar
  (:require [sketchybar.core :as sketchybar]
            [taoensso.timbre :as log]
            [util.config :as config]
            [util.helpers :as helpers]))

(defn setup []
  (log/debug "setting up item calendar")
  (sketchybar/exec
   (sketchybar/add-item :calendar :right)
   (sketchybar/set :calendar (merge config/item-defaults
                                    {:label              "loading"
                                     :label.padding_left 8
                                     :icon.drawing       "off"
                                     :script             (helpers/plugin-cmd 'plugins.calendar)
                                     :click_script       (helpers/plugin-cmd 'plugins.calendar-click)
                                     :update_freq        3
                                     :updates            "on"}))))

(defn -main [& _args]
  (setup))
