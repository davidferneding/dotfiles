(ns reload
  (:require [babashka.process :refer [shell sh]]))

(defn reload-tools! []
  (println "\nReloading tools...")

  (try
    (shell {:out :string :err :string :continue true}
           "tmux" "source-file" (str (System/getProperty "user.home") "/.tmux.conf"))
    (println "  ✓ tmux reloaded")
    (catch Exception _ (println "  · tmux not running")))

  (try
    (let [result (sh {:continue true} "pgrep" "-x" "sketchybar")]
      (when (= 0 (:exit result))
        (shell {:out :string :err :string :continue true} "brew" "services" "restart" "sketchybar")
        (println "  ✓ sketchybar restarted")))
    (catch Exception _ (println "  · sketchybar not running")))

  (try
    (let [result (sh {:continue true} "pgrep" "-x" "borders")]
      (when (= 0 (:exit result))
        (shell {:out :string :err :string :continue true} "brew" "services" "restart" "borders")
        (println "  ✓ borders restarted")))
    (catch Exception _ (println "  · borders not running")))

  (println "\n  ℹ Restart nvim to apply the new theme."))
