#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})

(ns items.slack
  (:require [sketchybar.core :as sketchybar]
            [clojure.string]
            [config]
            [taoensso.timbre :as log]))

(defn setup []
  (log/debug "setting up item slack")
  (sketchybar/exec
   (sketchybar/add-item :slack :right)
   (sketchybar/set :slack (conj config/item {:icon ":slack:"
                                             :script (str config/plugin-dir "/slack.clj")
                                             :update_freq 3}))))

(setup)
