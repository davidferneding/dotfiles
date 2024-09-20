#!/usr/bin/env bb
(require '[babashka.process :refer [shell sh]]
         '[clojure.string :as string])

(def config-folder (str (System/getProperty "user.home") "/.config/aerospace/"))

(def keyboard-layout (string/replace
                      (string/replace
                       (:out (sh (str "defaults read "  (System/getProperty "user.home") "/Library/Preferences/com.apple.HIToolbox.plist" " AppleSelectedInputSources")))
                       "\n" "")
                      #".*\"KeyboardLayout Name\" = \"?(.*?)\"? ?;.*" "$1"))

(def monitors (string/split (:out (shell {:out :string :err :string :continue true} "aerospace list-monitors")) #"\n"))

(def uses-built-in? (true? (some #(string/includes? % "built-in") (map string/lower-case monitors))))
(def external-monitor-count (if uses-built-in? (- (count monitors) 1) (count monitors)))

(def keymap (case keyboard-layout
              "Dvorak" (slurp (str config-folder "keymap.dvorak.toml"))
              (slurp (str config-folder "keymap.qwerty.toml"))))

(def base (slurp (str config-folder "base.toml")))

(def movement (str (slurp (str config-folder "movement.base.toml"))
                   (if uses-built-in? (slurp (str config-folder "movement.built-in.toml")) "")
                   (if (> external-monitor-count 1) (slurp (str config-folder "movement.left.toml")) "")
                   (if (> external-monitor-count 0) (slurp (str config-folder "movement.right.toml")) "")))

(def workspaces (str (slurp (str config-folder "workspaces.base.toml"))
                     (if uses-built-in?
                       (str (slurp (str config-folder "workspaces.built-in.toml"))
                            (if (> external-monitor-count 1) (slurp (str config-folder "workspaces.open.left.toml")) "")
                            (if (> external-monitor-count 0) (slurp (str config-folder "workspaces.open.right.toml")) ""))
                       (str (if (> external-monitor-count 1) (slurp (str config-folder "workspaces.closed.left.toml")) "")
                            (if (> external-monitor-count 0) (slurp (str config-folder "workspaces.closed.right.toml")) "")))))

(spit (str config-folder "aerospace.toml") (str keymap base movement workspaces))

(shell {:continue true} "aerospace reload-config")
