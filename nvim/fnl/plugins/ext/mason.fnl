[{1 :williamboman/mason.nvim
  :version "*"
  :config (fn []
            (local mason (require :mason))
            (mason.setup))
  :priority 1000
  ;; load and init this before anything else
  }
 {1 :williamboman/mason-lspconfig.nvim
  :version "*"
  :config (fn []
            (local mason-lspconfig (require :mason-lspconfig))
            (mason-lspconfig.setup {:ensure_installed [:clojure_lsp
                                                       :fennel_ls
                                                       :lua_ls
                                                       :marksman
                                                       :omnisharp
                                                       :prettier
                                                       :tailwindcss
                                                       :ts_ls]
                                    :automatic_installation true})
            (mason-lspconfig.setup_handlers {1 (fn [server_name]
                                                 (local lspconfig
                                                        (. (require :lspconfig)
                                                           server_name))
                                                 (lspconfig.setup {}))
                                             ;; add overrides if needed
                                             ;; 2 (local [:rust_analyzer] (fn [] (local rust_analyzer (require :rust-tools)) (rust_analyzer.setup {})))
                                             }))
  :priority 999
  ;; and this after mason
  }]
