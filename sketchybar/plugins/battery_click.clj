#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})

(ns plugins.battery-click
  (:require [sketchybar.core :as sketchybar]
            [taoensso.timbre :as log]))

(defn label-active? []
  (= "on" (:drawing (:label (sketchybar/query "battery")))))

(let [turn-off? (label-active?)]
  (log/debug (str "turning label for battery " (if turn-off? "off" "on")))
  (sketchybar/exec (sketchybar/set :battery {:label.drawing (if turn-off? "off" "on")})))

