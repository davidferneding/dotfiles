#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})
(require '[babashka.process :refer [shell]]
         '[clojure.string :as string]
         '[sketchybar.core :as sketchybar]
         '[clojure.edn :as edn])

(defn extract-key [text]
  (string/replace text #" \|.*" ""))

(defn get-monitors [] (map extract-key (string/split (:out (shell {:out :string :err :string :continue true} "aerospace list-monitors")) #"\n")))

(defn get-focused-workspace [monitor]
  (first (string/split (:out (shell {:out :string :err :string :continue true} "aerospace list-workspaces --monitor" monitor "--visible")) #"\n")))

(defn get-workspaces [monitor]
  (string/split (:out (shell {:out :string :err :string :continue true} "aerospace list-workspaces --monitor" monitor)) #"\n"))

(defn extract-app-name [process]
  (if (or (nil? process) (= 0 (count process))) ""
      (let [name-dirty (re-find #"\| .*? \|" process)]
        (re-find #"\w[\w\s]*\w" name-dirty))))

(defn get-apps [space]
  (map extract-app-name (string/split (:out (shell {:out :string :err :string :continue true} "aerospace list-windows --workspace" space)) #"\n")))

(defn space-key [space]
  (str "space." space))

(def app-icons (edn/read-string (slurp (str (System/getProperty "user.home") "/.config/sketchybar/icon_map.edn"))))

(defn get-icon [app] (let [icon (get app-icons app)] (if (nil? icon) ":default:" icon)))

(defn build-icon-strip [apps]
  (if (or (nil? apps) (empty? apps) (every? empty? apps)) "—" (string/join " " (map get-icon apps))))

(defn update-space [space-key icons highlight?]
  (sketchybar/exec (sketchybar/set space-key {:label icons
                                              :icon.highlight highlight?})))

(def click-future (future (when (= (System/getenv "SENDER") "mouse.clicked")
                            (shell {:continue true} "aerospace workspace" (string/replace (System/getenv "NAME") "space." "")))))

(def update-futures (for [monitor (get-monitors)]
                      (let [focused-workspace (get-focused-workspace monitor)]
                        (for [workspace (get-workspaces monitor)]
                          (future (update-space (space-key workspace) (build-icon-strip (get-apps workspace)) (= focused-workspace workspace)))))))

@click-future
(mapv deref (flatten update-futures))

