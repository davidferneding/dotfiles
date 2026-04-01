(ns plugins.calendar
  (:require [sketchybar.core :as sketchybar]
            [taoensso.timbre :as log]))

(defn -main [& _args]
  (try
    (sketchybar/exec
     (sketchybar/set :calendar
                     {:label (.format (java.text.SimpleDateFormat. "yyyy-MM-dd HH:mm")
                                      (java.util.Date.))}))
    (catch Exception ex
      (log/error ex "error while updating calendar"))))
