(tset vim.g :mapleader " ")
(tset vim.g :maplocalleader " ")

(fn map [modes key command ?desc]
  (vim.keymap.set modes key command {:desc ?desc}))

(fn lmap [modes key command ?desc]
  (map modes (.. :<leader> key) command ?desc))

(fn cmd [command]
  (.. :<cmd> command :<cr>))

(map [:i :v] :jk :<Esc> "Back to normal mode")

(lmap :v :y "\"*y" "yank to system clipboard")

;; lsp
(local lspbuf vim.lsp.buf)
(lmap :n :jd lspbuf.definition "jump to definition")
(lmap :n :ji lspbuf.implementation "jump to implementation")
(lmap :n :jc lspbuf.incoming_calls "jump to incoming calls")
(lmap :n :jr lspbuf.references "jump to references")
(map [:i :n] :<C-i> lspbuf.hover "show hover information")
(map [:i :n] :<C-a> lspbuf.code_action "show code actions")
(lmap :n :rn lspbuf.rename :rename)
(lmap :n :ff lspbuf.format "format file")
(lmap :v :ff lspbuf.format "format range")

;; nvim-tree
(lmap :n :ts (cmd :NvimTreeFocus) "focus file tree")
(lmap :n :th (cmd :NvimTreeClose) "hide tree")

;; new lines without leaving normal mode
(lmap :n :o :o<Esc> :below)
(lmap :n :O :O<Esc> :above)

;; telescope
(lmap :n :tf (cmd ":Telescope find_files") "telescope find_files")
(lmap :n :tg (cmd ":Telescope live_grep") "telescope live_grep")

;; harpoon
(map [:i :n] :<C-h>a (cmd :HarpoonAppend) "add buffer to harpoon")
(map [:i :n] :<C-h><C-a> (cmd :HarpoonAppend) "add buffer to harpoon")
(map [:i :n] :<C-h>r (cmd :HarpoonRemove) "remove buffer from harpoon")
(map [:i :n] :<C-h><C-r> (cmd :HarpoonRemove) "remove buffer from harpoon")
(map [:i :n] :<C-h>s (cmd :HarpoonShow) "show harpoon list")
(map [:i :n] :<C-h><C-s> (cmd :HarpoonShow) "show harpoon list")
(map [:i :n] :<C-k> (cmd :HarpoonPrev) "jump to previous harpooned buffer")
(map [:i :n] :<C-j> (cmd :HarpoonNext) "jump to next harpooned buffer")

(lmap :n :1 (cmd "HarpoonSwitch 1") "jump to harpoon buffer 1")
(lmap :n :2 (cmd "HarpoonSwitch 2") "jump to harpoon buffer 2")
(lmap :n :3 (cmd "HarpoonSwitch 3") "jump to harpoon buffer 3")
(lmap :n :4 (cmd "HarpoonSwitch 4") "jump to harpoon buffer 4")
(lmap :n :5 (cmd "HarpoonSwitch 5") "jump to harpoon buffer 5")
(lmap :n :6 (cmd "HarpoonSwitch 6") "jump to harpoon buffer 6")
(lmap :n :7 (cmd "HarpoonSwitch 7") "jump to harpoon buffer 7")
(lmap :n :8 (cmd "HarpoonSwitch 8") "jump to harpoon buffer 8")
(lmap :n :9 (cmd "HarpoonSwitch 9") "jump to harpoon buffer 9")

;; other movement shortcuts
(lmap :n :h (cmd :bprev) "go to previous buffer")
(lmap :n :l (cmd :bnext) "go to next buffer")

;; resize windows
(map :n :<S-Up> (cmd ":res -1") "resize window")
(map :n :<S-Down> (cmd ":res +1") "resize window")
(map :n :<S-Left> (cmd ":vert res +1") "resize window")
(map :n :<S-Right> (cmd ":vert res -1") "resize window")

;; diff / merge
(lmap :n :dn "]c" "next diff")
(lmap :n :dp "[c" "prev diff")
(lmap :n :dg (cmd ":diffget") "use other change (two way diff)")
(lmap :n :dl (cmd ":diffget local") "use local change")
(lmap :n :dr (cmd ":diffget remote") "use change from remote")

;; notes
(map [:i :n] :<C-g><C-n> (cmd :GlobalNote) "open/close global notes")

;; undo tree
(lmap :n :ut (cmd :UndotreeToggle) "toggle undo tree")

