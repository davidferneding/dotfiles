#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})
(require '[sketchybar.core :as sketchybar])

(defn label-active? []
  (= "on" (:drawing (:label (sketchybar/query "battery")))))

(sketchybar/exec (sketchybar/set :battery {:label.drawing (if (label-active?) "off" "on")}))

