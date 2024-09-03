{1 :nvim-tree/nvim-tree.lua
 :version "*"
 :lazy false
 :dependencies {1 :nvim-tree/nvim-web-devicons}
 :config (fn []
           (fn directory? [file]
             (= file.type :directory))

           (fn compare-number [left right start-index]
             (let [left-num (tonumber (string.match (string.sub left
                                                                start-index -1)
                                                    "^[0-9]+"))
                   right-num (tonumber (string.match (string.sub right
                                                                 start-index -1)
                                                     "^[0-9]+"))]
               (if (= left-num right-num) :same
                   (if (< left-num right-num) :use-left :use-right))))

           (fn number? [text]
             (= (type (tonumber text)) :number))

           (fn compare-char [left-char right-char]
             (if (= left-char right-char) :same
                 (if (< left-char right-char) :use-left :use-right)))

           (fn compare [left right index]
             (if (> index (string.len left))
                 :use-left
                 (if (> index (string.len right))
                     :use-right
                     (let [left-char (string.sub left index index)
                           right-char (string.sub right index index)]
                       (if (and (number? left-char) (number? right-char))
                           (let [compare-number-result (compare-number left
                                                                       right
                                                                       index)]
                             (if (= :same compare-number-result)
                                 (compare left right (+ 1 index))
                                 compare-number-result))
                           (let [compare-char-result (compare-char left-char
                                                                   right-char)]
                             (if (= :same compare-char-result)
                                 (compare left right (+ 1 index))
                                 compare-char-result)))))))

           (fn natural-sort [left right]
             (if (not= (directory? left) (directory? right))
                 (directory? left)
                 (if (= (left.name:lower) (right.name:lower))
                     false
                     (= :use-left (compare (left.name:lower) (right.name:lower)
                                           1)))))

           ((. (require :nvim-tree) :setup) {:view {:width {:min 30 :max 100}}
                                             :sort_by (fn [nodes]
                                                        (table.sort nodes
                                                                    natural-sort))
                                             :actions {:open_file {:quit_on_open true}}}))}

