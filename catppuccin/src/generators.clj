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

(defn gen-sketchybar-edn [colors]
  (let [latte-text "4c4f69"]
    (pr-str {:bg         (hex->0xff (:base colors))
             :text-light (hex->0xff (:text colors))
             :text-dark  (hex->0xff latte-text)
             :red        (hex->0xff (:red colors))
             :rosewater  (hex->0xff (:rosewater colors))})))

(defn gen-borders-sh [colors]
  (str/join "\n"
            [(str "ACTIVE_COLOR=" (hex->0xff (:rosewater colors)))
             (str "INACTIVE_COLOR=" (hex->0xff (:overlay-0 colors)))
             ""]))
