(ns plugins.front-app
  (:require [babashka.process :refer [shell]]
            [sketchybar.core :as sketchybar]
            [taoensso.timbre :as log]
            [util.helpers :as helpers]))

(defn- focused-process []
  (:out (shell {:out :string :err :string :continue true}
               "aerospace list-windows --focused")))

(defn- app-name [process]
  (when (and process (pos? (count process)))
    (some-> (re-find #"\| .*? \|" process)
            (as-> s (subs s 2 (- (count s) 2))))))

(defn -main [& _args]
  (try
    (let [app (app-name (focused-process))]
      (log/debug (str "updating front app to " app))
      (sketchybar/exec
       (sketchybar/set :front_app
                       (if (or (nil? app) (= app ""))
                         {:drawing "off"}
                         {:label   app
                          :icon    (helpers/get-icon app)
                          :drawing "on"}))))
    (catch Exception ex
      (log/error ex "error while updating front app"))))
