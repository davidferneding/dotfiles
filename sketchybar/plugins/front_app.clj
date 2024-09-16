#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})
(require '[babashka.process :refer [shell]]
         '[sketchybar.core :as sketchybar]
         '[clojure.string]
         '[clojure.edn :as edn])

(defn focused-process []
  (:out (shell {:out :string :err :string :continue true} "aerospace list-windows --focused")))

(defn app-name [process]
  (if (or (nil? process) (= 0 (count process))) ""
      (let [name-dirty (re-find #"\| .*? \|" process)]
        (subs name-dirty 2 (- (count name-dirty) 2)))))

(def app-icons (edn/read-string (slurp (str (System/getProperty "user.home") "/.config/sketchybar/plugins/icon_map.edn"))))

(defn refresh []
  (let [app (app-name (focused-process))]
    (sketchybar/exec (sketchybar/set :front_app (if (= app "")
                                                  {:drawing "off"}
                                                  {:label app
                                                   :icon (get app-icons app)
                                                   :drawing "on"})))))

(refresh)
