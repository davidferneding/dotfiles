#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})
(require '[sketchybar.core :as sketchybar]
         '[clojure.string]
         '[config])

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :mail :right)
   (sketchybar/set :mail (conj config/item {:icon ":mail:"
                                            :script (str config/plugin-dir "/mail.clj")
                                            :update_freq 3}))))

(setup)
