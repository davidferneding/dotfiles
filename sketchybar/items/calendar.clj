#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})
(require '[sketchybar.core :as sketchybar]
         '[config])

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :calendar :right)
   (sketchybar/set :calendar (conj config/item {:label "loading"
                                                :label.align "right"

                                                :script (str config/plugin-dir "/calendar.clj")
                                                :update_freq 3
                                                :updates "on"}))))

(setup)
