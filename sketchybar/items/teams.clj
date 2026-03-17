#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})

(ns items.teams
  (:require [sketchybar.core :as sketchybar]
            [clojure.string]
            [config]
            [taoensso.timbre :as log]))

(defn setup []
  (log/debug "setting up item teams")
  (sketchybar/exec
   (sketchybar/add-item :teams :right)
   (sketchybar/set :teams (conj config/item {:icon ":microsoft_teams:"
                                             :script (str config/plugin-dir "/teams.clj")
                                             :update_freq 3}))))

(setup)
