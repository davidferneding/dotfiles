(ns core
  (:require [bblgum.core :as gum]
            [clojure.edn :as edn]
            [clojure.string :as str]
            [generators :as gen]
            [reload]))

(def config-dir (str (System/getProperty "user.home") "/.config"))

(def flavors
  (edn/read-string (slurp (str config-dir "/catppuccin/themes.edn"))))

(def display-names
  {:latte     "Catppuccin Latte"
   :frappe    "Catppuccin Frappé"
   :macchiato "Catppuccin Macchiato"
   :mocha     "Catppuccin Mocha"})

(def paths
  {:theme-edn      (str config-dir "/theme.edn")
   :tmux-theme     (str config-dir "/tmux/theme.conf")
   :wezterm-theme  (str config-dir "/wezterm/theme.lua")
   :nvim-theme     (str config-dir "/nvim/lua/current-theme.lua")
   :sketchybar-edn (str config-dir "/sketchybar/resources/theme_colors.edn")
   :borders-theme  (str config-dir "/borders/theme_colors.sh")})

(defn generate-files! [flavor target-paths]
  (let [colors (get flavors flavor)]
    (gen/write-file! (:theme-edn target-paths)      (gen/gen-theme-edn flavor))
    (gen/write-file! (:tmux-theme target-paths)      (gen/gen-tmux-theme flavor))
    (gen/write-file! (:wezterm-theme target-paths)   (gen/gen-wezterm-theme flavor))
    (gen/write-file! (:nvim-theme target-paths)      (gen/gen-nvim-theme flavor colors))
    (gen/write-file! (:sketchybar-edn target-paths)  (gen/gen-sketchybar-edn colors))
    (gen/write-file! (:borders-theme target-paths)   (gen/gen-borders-sh colors))))

(defn select-flavor []
  (let [choices (mapv (fn [k] (str (name k) " - " (get display-names k)))
                      (sort (keys flavors)))
        result  (gum/gum :choose choices :header "Select a Catppuccin flavor:")]
    (when (= 0 (:status result))
      (let [selection (first (:result result))
            flavor    (keyword (first (str/split selection #" - ")))]
        (when (contains? flavors flavor)
          flavor)))))

(defn -main []
  (when-let [flavor (select-flavor)]
    (println (str "\nApplying " (get display-names flavor) "\n"))
    (generate-files! flavor paths)
    (reload/reload-tools!)))
