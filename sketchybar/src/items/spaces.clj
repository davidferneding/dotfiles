(ns items.spaces
  (:require [clojure.string :as str]
            [babashka.process :refer [shell]]
            [sketchybar.core :as sketchybar]
            [taoensso.timbre :as log]
            [util.config :as config]
            [util.helpers :as helpers]))

(defn- assoc-ids [text]
  (zipmap [:aerospace-monitor :system-monitor] (str/split text #" ")))

(defn- get-monitors []
  (map assoc-ids
       (str/split (:out (shell {:out :string :err :string :continue true}
                                  "aerospace list-monitors --format \"%{monitor-id} %{monitor-appkit-nsscreen-screens-id}\""))
                     #"\n")))

(defn- get-workspaces [monitor]
  (str/split (:out (shell {:out :string :err :string :continue true}
                              "aerospace list-workspaces --monitor" monitor))
                #"\n"))

(defn- extract-app-name [process]
  (when (and process (pos? (count process)))
    (some-> (re-find #"\| .*? \|" process)
            (as-> s (re-find #"\w[\w\s]*\w" s)))))

(defn- get-apps [space]
  (map extract-app-name
       (str/split (:out (shell {:out :string :err :string :continue true}
                                  "aerospace list-windows --workspace" space))
                     #"\n")))

(defn- space-key [space]
  (str "space." space))

(defn- build-icon-strip [apps]
  (if (or (nil? apps) (empty? apps) (every? empty? apps))
    "—"
    (str/join " " (map helpers/get-icon apps))))

(defn- add-space [space monitor]
  (sketchybar/exec
   (sketchybar/add-item (space-key space) :left)
   (sketchybar/set (space-key space)
                   (merge config/item-defaults
                          {:icon                  (str/upper-case space)
                           :icon.font             (config/label-font :weight "Bold" :size 16.0)
                           :display               monitor
                           :label.font            (config/icon-font)
                           :icon.highlight_color  (:text-dark config/colors)
                           :label.highlight_color (:text-dark config/colors)
                           :label.padding_left    4
                           :script                (helpers/plugin-cmd 'plugins.space)}))
   (sketchybar/subscribe (space-key space) "mouse.clicked")
   (sketchybar/subscribe (space-key space) "space_windows_change")
   (sketchybar/subscribe (space-key space) "aerospace_workspace_change")))

(defn- add-custom-events []
  (sketchybar/exec
   (sketchybar/add-event "aerospace_workspace_change")))

(defn setup []
  (doseq [monitor (get-monitors)]
    (doseq [aerospace-monitor (:aerospace-monitor monitor)
            system-monitor (:system-monitor monitor)
            workspace (get-workspaces aerospace-monitor)]
      (log/debug (str "setting up " workspace "/" aerospace-monitor))
      (add-custom-events)
      (add-space workspace system-monitor)
      (sketchybar/exec
       (sketchybar/set (space-key workspace)
                       {:label (build-icon-strip (get-apps workspace))})))))

(defn -main [& _args]
  (setup))
