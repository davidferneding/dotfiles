#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})

(ns items.battery
  (:require [sketchybar.core :as sketchybar]
            [clojure.string]
            [config]
            [taoensso.timbre :as log]))

(defn setup []
  (log/debug "setting up item battery")
  (sketchybar/exec
   (sketchybar/add-item :battery :right)
   (sketchybar/set :battery (conj config/item {:label "loading"
                                               :icon (:sync (:battery config/custom-icons))
                                               :icon.font (config/label-font :weight "Bold" :size 18.0)
                                               :icon.y_offset 1
                                               :script (str config/plugin-dir "/battery.clj")
                                               :click_script (str config/plugin-dir "/battery-click.clj")
                                               :update_freq 60}))
   (sketchybar/subscribe :battery :power_source_change)))

(setup)
