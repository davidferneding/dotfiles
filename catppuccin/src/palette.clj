(ns palette
  (:require [cheshire.core :as json]
            [clojure.string :as str]
            [clojure.pprint :as pp]))

(def palette-url
  "https://raw.githubusercontent.com/catppuccin/palette/main/palette.json")

(def config-dir (str (System/getProperty "user.home") "/.config"))
(def themes-path (str config-dir "/catppuccin/themes.edn"))

(defn- normalize-color-key
  "Converts palette.json keys like :subtext0 to :subtext-0."
  [k]
  (keyword (str/replace (name k) #"(\D)(\d)" "$1-$2")))

(defn- parse-palette [palette-json]
  (let [palette   (json/parse-string palette-json true)
        flavor-ks [:latte :frappe :macchiato :mocha]]
    (into {}
          (for [fk flavor-ks
                :let [colors (get-in palette [fk :colors])]]
            [fk (into (sorted-map)
                      (for [[ck cv] colors]
                        [(normalize-color-key ck)
                         (str/replace (:hex cv) "#" "")]))]))))

(defn update-themes! []
  (println (str "Fetching palette from " palette-url " ..."))
  (let [palette-json (slurp palette-url)
        themes       (parse-palette palette-json)]
    (spit themes-path (with-out-str (pp/pprint themes)))
    (println (str "  ✓ Updated " themes-path))))
