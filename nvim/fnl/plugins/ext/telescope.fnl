{1 :nvim-telescope/telescope.nvim
 :version "*"
 :dependencies [:nvim-lua/plenary.nvim]
 :config (fn []
           (local telescope (require :telescope))
           (telescope.load_extension :noice)
           (local actions (require :telescope.actions))
           (local config {:defaults {:mappings {:i {:<esc> actions.close}}}})
           (telescope.setup config))}
