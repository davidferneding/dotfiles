(ns plugins.battery-click
  (:require [sketchybar.core :as sketchybar]
            [taoensso.timbre :as log]))

(defn -main [& _args]
  (let [turn-off? (= "on" (:drawing (:label (sketchybar/query "battery"))))]
    (log/debug (str "turning label for battery " (if turn-off? "off" "on")))
    (sketchybar/exec (sketchybar/set :battery {:label.drawing (if turn-off? "off" "on")}))))
