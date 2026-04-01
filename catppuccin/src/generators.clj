(ns generators
  (:require [clojure.string :as str]
            [clojure.java.io :as io]))

(defn hex->0xff [hex]
  (str "0xff" hex))

(defn hex->hash [hex]
  (str "#" hex))

(defn write-file! [path content]
  (io/make-parents path)
  (spit path content)
  (println (str "  ✓ " path)))

;; ─── File generators ─────────────────────────────────────────────────

(defn gen-theme-edn [flavor]
  (pr-str {:flavor flavor}))

(defn gen-tmux-theme [flavor]
  (str/join "\n"
            [(str "set -g @catppuccin_flavor \"" (name flavor) "\"")
             "set -g @catppuccin_status_background \"none\""
             "set -g @catppuccin_pane_status_enabled \"off\""
             "set -g @catppuccin_pane_border_status \"off\""
             ""
             "run ~/.config/tmux/plugins/catppuccin/catppuccin.tmux"
             ""]))

(defn gen-wezterm-theme [flavor]
  (let [scheme (str "Catppuccin " (str/capitalize (name flavor)))]
    (str "return { color_scheme = \"" scheme "\" }\n")))

(defn gen-nvim-theme [flavor colors]
  (let [colorscheme (str "catppuccin-" (name flavor))
        lines (concat
               ["return {"
                (str "  colorscheme = \"" colorscheme "\",")
                "  colors = {"]
               (for [[k v] (sort-by (comp name first) colors)]
                 (let [lua-key (str/replace (name k) "-" "_")]
                   (str "    " lua-key " = \"" (hex->hash v) "\",")))
               ["  }" "}" ""])]
    (str/join "\n" lines)))

(defn gen-sketchybar-sh [colors]
  (let [mapping [["BLACK"       :crust]
                 ["WHITE"       :text]
                 ["RED"         :red]
                 ["GREEN"       :green]
                 ["BLUE"        :blue]
                 ["YELLOW"      :yellow]
                 ["ORANGE"      :peach]
                 ["MAGENTA"     :mauve]
                 ["GREY"        :overlay-1]
                 ["TRANSPARENT" nil]
                 ["BG0"         :base]
                 ["BG1"         :surface-0]
                 ["BG2"         :surface-1]]
        battery [["BATTERY_1" :green]
                 ["BATTERY_2" :yellow]
                 ["BATTERY_3" :peach]
                 ["BATTERY_4" :maroon]
                 ["BATTERY_5" :red]]]
    (str/join "\n"
              (concat
               (for [[var-name color-key] mapping]
                 (if (nil? color-key)
                   (str "export " var-name "=0x00000000")
                   (str "export " var-name "=" (hex->0xff (get colors color-key)))))
               [""]
               (for [[var-name color-key] battery]
                 (str "export " var-name "=" (hex->0xff (get colors color-key))))
               [""]))))

(defn gen-sketchybar-edn [colors]
  (let [latte-text "4c4f69"]
    (pr-str {:bg         (read-string (hex->0xff (:base colors)))
             :text-light (read-string (hex->0xff (:text colors)))
             :text-dark  (read-string (hex->0xff latte-text))
             :red        (read-string (hex->0xff (:red colors)))
             :rosewater  (read-string (hex->0xff (:rosewater colors)))})))

(defn gen-borders-sh [colors]
  (str/join "\n"
            [(str "ACTIVE_COLOR=" (hex->0xff (:rosewater colors)))
             (str "INACTIVE_COLOR=" (hex->0xff (:overlay-0 colors)))
             ""]))
