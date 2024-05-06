(tset vim.g :mapleader " ")
(tset vim.g :maplocalleader " ")

(fn map [modes key command ?desc]
  (vim.keymap.set modes key command {:desc ?desc}))

(fn lmap [modes key command ?desc]
  (map modes (.. :<leader> key) command ?desc))

(fn cmd [command]
  (.. :<cmd> command :<cr>))

(map [:i :v] :jk :<Esc> "Back to normal mode")

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

;; -- nvim-tree
(lmap :n :ts (cmd :NvimTreeFocus) "focus file tree")
(lmap :n :th (cmd :NvimTreeClose) "hide tree")

;; -- new lines without leaving normal mode
(lmap :n :o :o<Esc> :below)
(lmap :n :O :O<Esc> :above)

;; -- telescope
(lmap :n :tf (cmd ":Telescope find_files") "telescope find_files")
(lmap :n :tg (cmd ":Telescope live_grep") "telescope live_grep")

;; -- harpoon
(map [:i :n] :<C-h><C-a> (cmd :HarpoonAppend) "add buffer to harpoon")
(map [:i :n] :<C-h><C-r> (cmd :HarpoonRemove) "remove buffer from harpoon")
(map [:i :n] :<C-h><C-s> (cmd :HarpoonShow) "show harpoon list")
(map [:i :n] :<C-k> (cmd :HarpoonPrev) "jump to previous harpooned buffer")
(map [:i :n] :<C-j> (cmd :HarpoonNext) "jump to next harpooned buffer")

(map [:i :n] :<C-h>1 (cmd "HarpoonSwitch 1") "jump to harpoon buffer 1")
(map [:i :n] :<C-h>2 (cmd "HarpoonSwitch 2") "jump to harpoon buffer 2")
(map [:i :n] :<C-h>3 (cmd "HarpoonSwitch 3") "jump to harpoon buffer 3")
(map [:i :n] :<C-h>4 (cmd "HarpoonSwitch 4") "jump to harpoon buffer 4")
(map [:i :n] :<C-h>5 (cmd "HarpoonSwitch 5") "jump to harpoon buffer 5")
(map [:i :n] :<C-h>6 (cmd "HarpoonSwitch 6") "jump to harpoon buffer 6")
(map [:i :n] :<C-h>7 (cmd "HarpoonSwitch 7") "jump to harpoon buffer 7")
(map [:i :n] :<C-h>8 (cmd "HarpoonSwitch 8") "jump to harpoon buffer 8")
(map [:i :n] :<C-h>9 (cmd "HarpoonSwitch 9") "jump to harpoon buffer 9")

;; -- resize windows
(map :n :<S-Up> (cmd ":res -1") "resize window")
(map :n :<S-Down> (cmd ":res +1") "resize window")
(map :n :<S-Left> (cmd ":vert res +1") "resize window")
(map :n :<S-Right> (cmd ":vert res -1") "resize window")

;; -- diff / merge
(lmap :n :dn "]c" "next diff")
(lmap :n :dp "[c" "prev diff")
(lmap :n :<leader>dg (cmd ":diffget") "use other change (two way diff)")
(lmap :n :<leader>dl (cmd ":diffget local") "use local change")
(lmap :n :<leader>dr (cmd ":diffget remote") "use change from remote")

;; -- notes
(map [:i :n] :<C-g><C-n> (cmd :GlobalNote) "open/close global notes")

