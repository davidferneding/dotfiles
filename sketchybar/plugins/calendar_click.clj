#!/usr/bin/env bb
(ns plugins.calendar-click
  (:require [babashka.process :refer [sh]]
            [taoensso.timbre :as log]))

(->
  (log/debug (str "calendar clicked, showing notification center"))
  (sh "osascript -e 'tell application \"System Events\" to click menu bar item 2 of menu bar 1 of application process \"ControlCenter\"'"))

