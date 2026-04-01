(ns util.notifications
  "Shared helper for querying macOS app badge counts via lsappinfo."
  (:require [babashka.process :refer [sh]]
            [cheshire.core :as json]
            [clojure.string :as str]))

(defn number-string?
  "Returns true when every character in `s` is a digit."
  [s]
  (and (seq s) (every? #(Character/isDigit %) s)))

(defn get-badge-count
  "Query the badge count for `display-name` (e.g. \"Slack\", \"Microsoft Outlook\").
   Returns an integer: the badge number, 1 for a non-numeric badge, or 0 when absent."
  [display-name]
  (let [plain (:out (sh "lsappinfo info -only StatusLabel"
                        (:out (sh (str "lsappinfo find LSDisplayName='" display-name "'")))))]
    (if (or (nil? plain) (= "" plain) (str/includes? plain "NULL"))
      0
      (let [status (json/parse-string (str/replace (re-find #"\{.*" plain) "=" ":") true)]
        (cond
          (= (:label status) "") 0
          (number-string? (:label status)) (parse-long (:label status))
          :else 1)))))
