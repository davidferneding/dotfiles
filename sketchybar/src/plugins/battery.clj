(ns plugins.battery
  (:require [clojure.string :as str]
            [babashka.process :refer [sh]]
            [sketchybar.core :as sketchybar]
            [taoensso.timbre :as log]
            [util.config :as config]))

(defn- get-power-stats []
  (let [stat-list (map str/trim
                       (str/split (str/replace (:out (sh "pmset -g batt"))
                                               #" present.*" "")
                                  #"[\n\t;]"))]
    (if (empty? stat-list)
      {:errors [:not-found]}
      {:source    (if (str/includes? (first stat-list) "AC Power") :ac :battery)
       :percent   (first (filter #(re-matches #"\d{1,3}%" %) stat-list))
       :remaining (last stat-list)})))

(defn- extract-number [s]
  (parse-long (str/replace s #"\D" "")))

(defn- build-label [stats]
  (if (seq (:errors stats))
    "error"
    (str (:percent stats)
         (when (or (= "not charging" (:remaining stats))
                   (> (extract-number (:remaining stats)) 0))
           (str " " (:remaining stats))))))

(defn- get-icon [stats]
  (let [icons (:battery config/custom-icons)]
    (if (seq (:errors stats))
      (:error icons)
      (let [percent-icons (if (= (:source stats) :ac)
                            (:charge icons)
                            (:discharge icons))]
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
          (:10 percent-icons))))))

(defn -main [& _args]
  (try
    (let [stats (get-power-stats)]
      (sketchybar/exec (sketchybar/set :battery {:label (build-label stats)
                                                 :icon  (get-icon stats)})))
    (catch Exception ex
      (log/error ex "error while updating battery"))))
