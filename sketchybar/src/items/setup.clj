(ns items.setup
  "Orchestrates the full sketchybar setup: bar defaults + all items."
  (:require [items.bar :as bar]
            [items.spaces :as spaces]
            [items.front-app :as front-app]
            [items.calendar :as calendar]
            [items.battery :as battery]
            [items.notification :as notification]
            [taoensso.timbre :as log]))

(defn -main [& _args]
  (log/info "starting sketchybar setup")

  ;; Bar appearance & global defaults
  (bar/setup)

  ;; Left side
  (spaces/setup)
  (front-app/setup)

  ;; Right side
  (calendar/setup)
  (battery/setup)
  (notification/setup)

  (log/info "sketchybar setup complete"))
