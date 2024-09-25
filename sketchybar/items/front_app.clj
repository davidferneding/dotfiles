#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})

(ns items.front_app
  (:require [sketchybar.core :as sketchybar]
            [config]
            [taoensso.timbre :as log]))

(defn setup []
  (log/debug "setting up item front_app")
  (sketchybar/exec
   (sketchybar/add-item :front_app :left)
   (sketchybar/set :front_app (conj config/item {:display "active"
                                                 :label.padding_left 4
                                                 :script (str config/plugin-dir "/front_app.clj")}))
   (sketchybar/subscribe :front_app :front_app_switched)))

(setup)
