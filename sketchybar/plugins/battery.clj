#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})
(require '[babashka.process :refer [sh]]
         '[sketchybar.core :as sketchybar]
         '[clojure.edn :as edn]
         '[clojure.string :as str])

(defn get-power-stats []
  (let [stat-list (map str/trim (str/split (str/replace (:out (sh "pmset -g batt")) #" present.*" "") #"[\n\t;]"))]
    (if (empty? stat-list) {:errors [:not-found]}
        {:source (if (str/includes? (first stat-list) "AC Power") :ac :battery)
         :percent (first (filter #(not (nil? (re-matches #"\d{1,3}%" %))) stat-list))
         :remaining (last stat-list)}))) ; #'user/get-power-stats

(defn extract-number [string]
  (read-string (str/replace string #"\D" "")))

(defn build-label [stats]
  (if (seq (:errors stats))
    "error"
    (str (:percent stats)
         (when (> (extract-number (:remaining stats)) 0)
           (str " | " (:remaining stats))))))

(build-label (get-power-stats))

(def icons (edn/read-string (slurp (str (System/getProperty "user.home") "/.config/sketchybar/custom_icons.edn"))))

(defn get-icon [stats]
  (if (seq (:errors stats))
    (:error (:battery icons))
    (let [percent-icons (if (= (:source stats) :ac)
                          (:charge (:battery icons))
                          (:discharge (:battery icons)))]
      (condp <= (extract-number (:percent stats))
        90 (:100 percent-icons)
        80 (:90 percent-icons)
        70 (:80 percent-icons)
        60 (:70 percent-icons)
        50 (:60 percent-icons)
        40 (:50 percent-icons)
        30 (:40 percent-icons)
        20 (:30 percent-icons)
        10 (:20 percent-icons)
        (:10 percent-icons)))))

(defn refresh []
  (try
    (let [stats (get-power-stats)]
      (sketchybar/exec (sketchybar/set :battery {:label (build-label stats)
                                                 :icon (get-icon stats)})))
    (catch Exception _ (println "error while updating mail notification count"))))

(refresh)
