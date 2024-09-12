#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})
(require '[sketchybar.core :as sketchybar]
         '[clojure.string]
         '[config])

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :slack :right)
   (sketchybar/set :slack (conj config/item {:icon ":slack:"
                                             :icon.font "sketchybar-app-font:Regular:16.0"
                                             :icon.padding_left 8

                                             :label "loading"
                                             :label.padding_right 8

                                             :script (str config/plugin-dir "/slack.clj")
                                             :update_freq 3}))))

(setup)
