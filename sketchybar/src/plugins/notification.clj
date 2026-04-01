(ns plugins.notification
  "Generic notification-badge plugin. Determines the app to query from the
   sketchybar item NAME env var, which matches a key in the notification apps
   registry."
  (:require [items.notification :as items]
            [sketchybar.core :as sketchybar]
            [taoensso.timbre :as log]
            [util.notifications :as notif]))

(defn -main [& _args]
  (let [item-name (keyword (System/getenv "NAME"))
        app-info  (get items/apps item-name)]
    (when app-info
      (try
        (let [cnt (notif/get-badge-count (:display-name app-info))]
          (log/debug (str "updating " (name item-name) ". Badge count: " cnt))
          (sketchybar/exec
           (sketchybar/set item-name
                           (if (pos? cnt)
                             {:label cnt :drawing "on"}
                             {:drawing "off"}))))
        (catch Exception ex
          (log/error ex (str "error while updating " (name item-name) " notification count")))))))
