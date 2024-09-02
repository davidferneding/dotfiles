[{1 :hrsh7th/cmp-nvim-lsp}
 {1 :hrsh7th/cmp-buffer}
 {1 :hrsh7th/cmp-path}
 {1 :hrsh7th/cmp-cmdline}
 {1 :hrsh7th/nvim-cmp
  :config (fn []
            (local cmp (require :cmp))
            (cmp.setup {:snippet {;; REQUIRED - you must specify a snippet engine
                                  :expand (fn [args]
                                            ;; (vim.fn["vsnip#anonymous"] args.body) ;; For `vsnip` users.
                                            (local luasnip (require :luasnip))
                                            (luasnip.lsp_expand args.body)
                                            ;; For `luasnip` users.
                                            ;; require('snippy').expand_snippet(args.body) ;; For `snippy` users.
                                            ;; vim.fn["UltiSnips#Anon"](args.body) ;; For `ultisnips` users.
                                            )}
                        :window {;; completion = cmp.config.window.bordered(),
                                 ;; documentation = cmp.config.window.bordered(),
                                 }
                        :mapping (cmp.mapping.preset.insert {:<C-b> (cmp.mapping.scroll_docs -4)
                                                             :<C-f> (cmp.mapping.scroll_docs 4)
                                                             :<C-BS> (cmp.mapping.abort)
                                                             :<Tab> (cmp.mapping (fn [fallback]
                                                                                   ;; This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
                                                                                   (if (cmp.visible)
                                                                                       (let [entry (cmp.get_selected_entry)]
                                                                                         (when (not entry)
                                                                                           (cmp.select_next_item {:behavior cmp.SelectBehavior.Select}))
                                                                                         (cmp.confirm))
                                                                                       (fallback)))
                                                                                 [:i
                                                                                  :s
                                                                                  :c])})
                        :sources (cmp.config.sources [{:name :nvim_lsp
                                                       :keyword_length 1}
                                                      {:name :luasnip
                                                       :keyword_length 2}
                                                      {:name :buffer
                                                       :keyword_length 3}])})
            ;; Set configuration for specific filetype.
            (cmp.setup.filetype :gitcommit
                                {:sources (cmp.config.sources [{:name :git}
                                                               ;; You can specify the `git` source if [you installed it](https://github.com/petertriho/cmp-git).
                                                               ]
                                                              [{:name :buffer}])})
            ;; Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            (cmp.setup.cmdline ["/" "?"]
                               {:mapping (cmp.mapping.preset.cmdline)
                                :sources [{:name :buffer}]})
            ;; Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            (cmp.setup.cmdline ":"
                               {:mapping (cmp.mapping.preset.cmdline)
                                :sources (cmp.config.sources [{:name :path}]
                                                             [{:name :cmdline}])})
            ;; Set up lspconfig.
            (local cmp_nvim_lsp (require :cmp_nvim_lsp))
            (cmp_nvim_lsp.default_capabilities))}]

