(ns items.notification
  "Generic notification-badge item. Parameterised by app display-name and icon."
  (:require [sketchybar.core :as sketchybar]
            [taoensso.timbre :as log]
            [util.config :as config]
            [util.helpers :as helpers]))

(def apps
  "Registry of notification apps: sketchybar item name → {:display-name :icon}."
  {:slack   {:display-name "Slack"              :icon ":slack:"}
   :outlook {:display-name "Microsoft Outlook"  :icon ":microsoft_outlook:"}
   :mail    {:display-name "Mail"               :icon ":mail:"}
   :teams   {:display-name "Microsoft Teams"    :icon ":microsoft_teams:"}})

(defn setup-one
  "Register a single notification item in sketchybar."
  [item-key {:keys [icon]}]
  (log/debug (str "setting up item " (name item-key)))
  (sketchybar/exec
   (sketchybar/add-item item-key :right)
   (sketchybar/set item-key (merge config/item-defaults
                                   {:icon       icon
                                    :script      (helpers/plugin-cmd 'plugins.notification)
                                    :update_freq 3}))))

(defn setup
  "Register all notification items."
  []
  (doseq [[k v] apps]
    (setup-one k v)))

(defn -main [& _args]
  (setup))
