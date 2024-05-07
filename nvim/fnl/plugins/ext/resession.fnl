{1 :stevearc/resession.nvim
 :config (fn []
           (local resession (require :resession))
           (resession.setup)
           (vim.keymap.set :n :<leader>ss resession.save
                           {:desc "Save current session"})
           (vim.keymap.set :n :<leader>sl resession.load
                           {:desc "Load saved session"})
           (vim.keymap.set :n :<leader>sd resession.delete
                           {:desc "Delete saved session"}))}

