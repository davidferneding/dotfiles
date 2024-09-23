(ns lf.add-item
  (:require [clojure.java.io :as io]
            [clojure.string :as str]))

(defn ask-filename []
  (print "add folder/file: ")
  (flush)
  (str/trim (read-line)))

(defn create-items [filename]
  (io/make-parents (str filename "a")) ; if only a folder is specified, this will ensure this folder is created
  (when (not (str/ends-with? filename "/"))
    (spit filename "")))

(create-items (if (nil? *command-line-args*) (ask-filename) (first *command-line-args*)))

