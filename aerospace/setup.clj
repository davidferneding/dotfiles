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

(def keymap (case keyboard-layout
              "Dvorak" (slurp (str config-folder "keymap.dvorak.toml"))
              (slurp (str config-folder "keymap.qwerty.toml"))))

(def base (slurp (str config-folder "base.toml")))

(def movement (str (slurp (str config-folder "movement.base.toml"))
                   (if (= (count monitors) 1) (slurp (str config-folder "movement.one.toml")) "")
                   (if (= (count monitors) 2) (slurp (str config-folder "movement.two.toml")) "")
                   (if (= (count monitors) 3) (slurp (str config-folder "movement.three.toml")) "")))

(def workspaces (str (slurp (str config-folder "workspaces.base.toml"))
                     (if (= (count monitors) 1) (slurp (str config-folder "workspaces.one.toml")) "")
                     (if (= (count monitors) 2) (slurp (str config-folder "workspaces.two.toml")) "")
                     (if (= (count monitors) 3) (slurp (str config-folder "workspaces.three.toml")) "")))

(spit (str config-folder "aerospace.toml") (str keymap base movement workspaces))

(shell {:continue true} "aerospace reload-config")
