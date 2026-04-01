(ns plugins.space
  (:require [clojure.edn :as edn]
            [clojure.string :as str]
            [babashka.process :refer [shell]]
            [sketchybar.core :as sketchybar]
            [taoensso.timbre :as log]
            [util.config :as config]
            [util.helpers :as helpers]))

(defn- get-apps []
  (edn/read-string
   (str "["
        (:out (shell {:out :string :continue true}
                     "aerospace list-windows --all --format \"{ :workspace \\\"%{workspace}\\\" :app \\\"%{app-name}\\\" }\""))
        "]")))

(defn- get-visible-workspaces []
  (str/split (:out (shell {:out :string :continue true}
                              "aerospace list-workspaces --visible --monitor all"))
                #"\n"))

(defn- get-hidden-workspaces []
  (str/split (:out (shell {:out :string :continue true}
                              "aerospace list-workspaces --visible no --monitor all"))
                #"\n"))

(defn- get-empty-workspaces []
  (str/split (:out (shell {:out :string :continue true}
                              "aerospace list-workspaces --empty --monitor all"))
                #"\n"))

(defn- space-key [space]
  (str "space." space))

(defn- build-icon-strip [apps]
  (str/join " " (map helpers/get-icon apps)))

(def ^:private update-apps
  (future
    (when (= (System/getenv "SENDER") "space_windows_change")
      (doseq [[workspace apps] (->> (get-apps)
                                     (group-by :workspace)
                                     (map (fn [[ws entries]] [ws (mapv :app entries)]))
                                     (into {}))]
        (try
          (log/debug (str "updating space " workspace))
          (sketchybar/exec
           (sketchybar/set (space-key workspace)
                           {:label (build-icon-strip apps)}))
          (catch Exception ex
            (log/error ex "error while updating apps for space" workspace)))))))

(def ^:private update-empty-workspaces
  (future
    (when (= (System/getenv "SENDER") "space_windows_change")
      (try
        (doseq [workspace (get-empty-workspaces)]
          (log/debug (str "updating label for empty space " workspace))
          (sketchybar/exec (sketchybar/set (space-key workspace) {:label "/"})))
        (catch Exception ex
          (log/error ex "error while updating empty workspaces"))))))

(def ^:private update-highlight
  (future
    (when (= (System/getenv "SENDER") "aerospace_workspace_change")
      (try
        (doseq [workspace (get-hidden-workspaces)]
          (log/debug (str "updating space " workspace ". Space is inactive"))
          (sketchybar/exec
           (sketchybar/set (space-key workspace)
                           {:label.highlight false
                            :icon.highlight  false
                            :background.color (:bg config/colors)})))
        (doseq [workspace (get-visible-workspaces)]
          (log/debug (str "updating space " workspace ". Space is active"))
          (sketchybar/exec
           (sketchybar/set (space-key workspace)
                           {:label.highlight true
                            :icon.highlight  true
                            :background.color (:rosewater config/colors)})))
        (catch Exception ex
          (log/error ex "error while updating highlights"))))))

(def ^:private handle-click
  (future
    (when (= (System/getenv "SENDER") "mouse.clicked")
      (shell {:continue true}
             "aerospace workspace" (str/replace (System/getenv "NAME") "space." "")))))

(defn -main [& _args]
  (log/debug (str "Updating spaces. Sender " (System/getenv "SENDER")))
  @handle-click
  @update-highlight
  @update-apps
  @update-empty-workspaces)
