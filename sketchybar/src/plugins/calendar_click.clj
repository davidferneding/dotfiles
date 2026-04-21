(ns plugins.calendar-click
  (:require [babashka.process :refer [sh]]
            [taoensso.timbre :as log]))

(defn -main [& _args]
  (log/debug "calendar clicked, showing notification center")
  (sh "osascript" "-e"
       "tell application \"System Events\" to click (first menu bar item of menu bar 1 of application process \"ControlCenter\" whose description is \"Clock\")"))
