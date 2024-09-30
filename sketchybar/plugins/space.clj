#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})

(ns plugins.space
  (:require [babashka.process :refer [shell]]
            [clojure.string :as string]
            [sketchybar.core :as sketchybar]
            [clojure.edn :as edn]
            [taoensso.timbre :as log]))

(defn get-apps
  "Returns a map of all running apps with their respective workspace."
  []
  (edn/read-string (str "[" (:out (shell {:out :string :continue true} "aerospace list-windows --all --format \"{ :workspace \\\"%{workspace}\\\" :app \\\"%{app-name}\\\" }\"")) "]")))

(defn get-visible-workspaces
  "Returns a list of all visible workspaces."
  []
  (string/split (:out (shell {:out :string :continue true} "aerospace list-workspaces --visible --monitor all")) #"\n"))

(defn get-hidden-workspaces
  "Returns a list of all non-visible workspaces."
  []
  (string/split (:out (shell {:out :string :continue true} "aerospace list-workspaces --visible no --monitor all")) #"\n"))

(defn get-empty-workspaces
  "Returns a list of all workspaces that don't contain any windows."
  []
  (string/split (:out (shell {:out :string :continue true} "aerospace list-workspaces --empty --monitor all")) #"\n"))

(defn space-key [space]
  (str "space." space))

(def app-icons (edn/read-string (slurp (str (System/getProperty "user.home") "/.config/sketchybar/icon_map.edn"))))

(defn get-icon [app] (let [icon (get app-icons app)] (if (nil? icon) ":default:" icon)))

(defn build-icon-strip [apps]
  (string/join " " (map get-icon apps)))

(def colors {:bg 0xff363a4f ;; todo: use a single config file
             :rosewater 0xfff4dbd6})

(defn all-by-key [key coll]
  (into [] (map #(key %) coll)))

(def update-apps
  (future (doseq [workspaces-with-apps (->> (get-apps)
                                            (group-by #(:workspace %))
                                            (map #(assoc {} (first %) (all-by-key :app (last %))))
                                            (into {}))]
            (try
              (log/debug (str "updating space " workspaces-with-apps))
              (let [workspace (first workspaces-with-apps)
                    apps (last workspaces-with-apps)]
                (sketchybar/exec (sketchybar/set (space-key workspace) {:label (build-icon-strip apps)})))
              (catch Exception ex (log/error ex "error while updating apps for space" workspaces-with-apps))))))

(def update-empty-workspaces
  (future
    (try
      (doseq [workspace (get-empty-workspaces)]
        (log/debug (str "updating label for empty space " workspace))
        (sketchybar/exec (sketchybar/set (space-key workspace) {:label "/"})))
      (catch Exception ex (log/error ex "error while updating highlights")))))

(def update-highlight
  (future
    (try
      (doseq [workspace (get-hidden-workspaces)]
        (log/debug (str "updating space " workspace ". Space is inactive"))
        (sketchybar/exec (sketchybar/set (space-key workspace) {:label.highlight false
                                                                :icon.highlight false
                                                                :background.color (:bg colors)})))
      (doseq [workspace (get-visible-workspaces)]
        (log/debug (str "updating space " workspace ". Space is active"))
        (sketchybar/exec (sketchybar/set (space-key workspace) {:label.highlight true
                                                                :icon.highlight true
                                                                :background.color (:rosewater colors)})))
      (catch Exception ex (log/error ex "error while updating highlights")))))

(def handle-click (future (when (= (System/getenv "SENDER") "mouse.clicked")
                            (shell {:continue true} "aerospace workspace" (string/replace (System/getenv "NAME") "space." "")))))

@handle-click
@update-highlight
@update-apps
@update-empty-workspaces
