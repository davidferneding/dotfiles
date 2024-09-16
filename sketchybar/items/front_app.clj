#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})
(require '[sketchybar.core :as sketchybar]
         '[config])

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :front_app :left)
   (sketchybar/set :front_app (conj config/item {:display "active"
                                                 :script (str config/plugin-dir "/front_app.clj")}))
   (sketchybar/subscribe :front_app :front_app_switched)))

(setup)
