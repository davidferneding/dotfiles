#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})
(require '[babashka.process :refer [sh]]
         '[cheshire.core :as json]
         '[sketchybar.core :as sketchybar]
         '[clojure.string])

(def plain (:out (sh "lsappinfo info -only StatusLabel" (:out (sh "lsappinfo find LSDisplayName=Slack")))))
(def slack-message-count (if (or (nil? plain) (= "" plain)) 0
                             (Integer. (:label (json/parse-string (clojure.string/replace (re-find #"\{.*" plain) "=" ":") true)))))

(def label-content (if (> slack-message-count 0) (str "(" slack-message-count ")") ""))
(sketchybar/exec (sketchybar/set :slack {:label label-content}))
