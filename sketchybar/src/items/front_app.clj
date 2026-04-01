(ns items.front-app
  (:require [sketchybar.core :as sketchybar]
            [taoensso.timbre :as log]
            [util.config :as config]
            [util.helpers :as helpers]))

(defn setup []
  (log/debug "setting up item front_app")
  (sketchybar/exec
   (sketchybar/add-item :front_app :left)
   (sketchybar/set :front_app (merge config/item-defaults
                                     {:display           "active"
                                      :label.padding_left 4
                                      :script            (helpers/plugin-cmd 'plugins.front-app)}))
   (sketchybar/subscribe :front_app :front_app_switched)))

(defn -main [& _args]
  (setup))
