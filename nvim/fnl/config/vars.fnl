(fn set-opt [key value]
  "Set a vim option"
  (tset vim.opt key value))

(local options {;; info column
                :number true
                :relativenumber true
                :signcolumn :yes
                ;; highlighting
                :syntax :ON
                :termguicolors true
                ;; case sensitivity
                :ignorecase true
                :smartcase true
                :incsearch true
                :hlsearch true
                ;; indentation
                :expandtab true
                :shiftwidth 4
                :softtabstop 4
                :tabstop 4
                ;; splitting
                :splitright true
                :splitbelow true})

(each [key value (pairs options)]
  (set-opt key value))

(vim.api.nvim_set_hl 0 :LineNr {:fg "#7777aa"})
(tset vim.g :netrw_bufsettings "noma nomod nu relativenumber nowrap ro nobl")
(tset vim.g :t_co 256)

