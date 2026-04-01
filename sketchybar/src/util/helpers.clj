(ns util.helpers
  (:require [util.config :as config]))

(def ^:private bb-config
  (str (System/getProperty "user.home") "/.config/sketchybar/bb.edn"))

(defn plugin-cmd
  "Build a bb --config command string to invoke a plugin namespace's -main fn."
  [ns-sym]
  (str "bb --config " bb-config " -m " ns-sym "/-main"))

(defn get-icon
  "Look up an app icon from the icon map. Returns \":default:\" when not found."
  [app-name]
  (get config/icon-map app-name ":default:"))
