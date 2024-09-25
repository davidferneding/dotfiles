#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})

(ns items.calendar
  (:require [sketchybar.core :as sketchybar]
            [config]
            [taoensso.timbre :as log]))

(defn setup []
  (log/debug "setting up item calendar")
  (sketchybar/exec
   (sketchybar/add-item :calendar :right)
   (sketchybar/set :calendar (conj config/item {:label "loading"
                                                :label.padding_left 8
                                                :icon.drawing "off"

                                                :script (str config/plugin-dir "/calendar.clj")
                                                :update_freq 3
                                                :updates "on"}))))

(setup)
