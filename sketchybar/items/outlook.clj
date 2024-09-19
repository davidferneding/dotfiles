#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})
(require '[sketchybar.core :as sketchybar]
         '[clojure.string]
         '[config])

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :outlook :right)
   (sketchybar/set :outlook (conj config/item {:icon ":microsoft_outlook:"
                                               :script (str config/plugin-dir "/outlook.clj")
                                               :update_freq 3}))))

(setup)
