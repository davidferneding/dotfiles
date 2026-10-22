(ns plugins.calendar-click
  (:require [babashka.process :refer [sh]]
            [taoensso.timbre :as log]))

(defn -main [& _args]
  (log/debug "calendar clicked, showing notification center")
  (sh "osascript" "-e"
       "tell application \"System Events\" to keystroke \"n\" using {control down, option down}"))
