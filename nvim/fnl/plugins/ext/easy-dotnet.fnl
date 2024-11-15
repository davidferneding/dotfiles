{1 :GustavEikaas/easy-dotnet.nvim
 :dependencies [:nvim-lua/plenary.nvim :nvim-telescope/telescope.nvim]
 :opts {:test_runner {:viewmode :split
                      :mappings {:run_test_from_buffer {:lhs :<leader>rt
                                                        :desc "run test"}
                                 :debug_test {:lhs :<leader>dt
                                              :desc "debug test"}
                                 :run_all {:lhs :<leader>rat
                                           :desc "run all tests"}}}}}
