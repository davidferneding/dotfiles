{1 :neovim/nvim-lspconfig
 :version "*"
 :config (fn []
           (local cmp (require :cmp_nvim_lsp))
           (local capabilities (cmp.default_capabilities))
           (local lspconfig (require :lspconfig))
           (lspconfig.omnisharp.setup {: capabilities
                                       :enable_roslyn_analysers true
                                       :enable_import_completion true
                                       :organize_imports_on_format true
                                       :filetypes [:cs
                                                   :vb
                                                   :csproj
                                                   :sln
                                                   :slnx
                                                   :props
                                                   :csx
                                                   :targets]}))}
