#!/usr/bin/env bb
(require '[babashka.process :refer [shell sh]]
         '[clojure.string :as string])

(def config-folder (str (System/getProperty "user.home") "/.config/aerospace/"))

(defn config-file [filename]
  (str config-folder filename))

(def keyboard-layout (string/replace
                      (string/replace
                       (:out (sh (str "defaults read "  (System/getProperty "user.home") "/Library/Preferences/com.apple.HIToolbox.plist" " AppleSelectedInputSources")))
                       "\n" "")
                      #".*\"KeyboardLayout Name\" = \"?(.*?)\"? ?;.*" "$1"))

(def monitors (string/split (:out (shell {:out :string :err :string :continue true} "aerospace list-monitors")) #"\n"))

(def keymap (case keyboard-layout
              "Dvorak" (slurp (config-file "keymap.dvorak.toml"))
              (slurp (config-file "keymap.qwerty.toml"))))

(def base (slurp (config-file "base.toml")))

(def movement-base (str (slurp (config-file "movement.base.toml"))
                        (if (= (count monitors) 1) (slurp (config-file "movement.one.toml")) "")
                        (if (= (count monitors) 2) (slurp (config-file "movement.two.toml")) "")
                        (if (= (count monitors) 3) (slurp (config-file "movement.three.toml")) "")))

(defn make-once [s]
  (string/replace s #"(?m)^(\S+ = )('(?!mode ).*')$" "$1[$2, 'mode main']"))

(def movement (str
               (slurp (config-file "movement.once.toml"))
               (make-once movement-base)
               (slurp (config-file "movement.sticky.toml"))
               movement-base))

(def workspaces (str (slurp (config-file "workspaces.base.toml"))
                     (if (= (count monitors) 1) (slurp (config-file "workspaces.one.toml")) "")
                     (if (= (count monitors) 2) (slurp (config-file "workspaces.two.toml")) "")
                     (if (= (count monitors) 3) (slurp (config-file "workspaces.three.toml")) "")))

(spit (config-file "aerospace.toml") (str keymap base movement workspaces))

(shell {:continue true} "aerospace reload-config")
