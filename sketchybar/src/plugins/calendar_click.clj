(ns plugins.calendar-click
  (:require [babashka.process :refer [sh]]
            [taoensso.timbre :as log]))

(defn -main [& _args]
  (log/debug "calendar clicked, showing notification center")
  (sh "osascript" "-e"
       "tell application \"System Events\" to click menu bar item 2 of menu bar 1 of application process \"ControlCenter\""))
