#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})

(ns plugins.front_app
  (:require [babashka.process :refer [shell]]
            [sketchybar.core :as sketchybar]
            [clojure.edn :as edn]
            [taoensso.timbre :as log]))

(defn focused-process []
  (:out (shell {:out :string :err :string :continue true} "aerospace list-windows --focused")))

(defn app-name [process]
  (if (or (nil? process) (= 0 (count process))) ""
      (let [name-dirty (re-find #"\| .*? \|" process)]
        (subs name-dirty 2 (- (count name-dirty) 2)))))

(def app-icons (edn/read-string (slurp (str (System/getProperty "user.home") "/.config/sketchybar/icon_map.edn"))))

(defn get-app-icon [app-name]
  (let [icon (get app-icons app-name)]
    (if (nil? icon) ":default:" icon)))

(defn refresh []
  (try
    (let [app (app-name (focused-process))]
      (log/debug (str "updating front app to " app-name))
      (sketchybar/exec (sketchybar/set :front_app (if (= app "")
                                                    {:drawing "off"}
                                                    {:label app
                                                     :icon (get-app-icon app)
                                                     :drawing "on"}))))
    (catch Exception ex (log/error "error while updating front app"))))

(refresh)
