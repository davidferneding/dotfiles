return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        opts = {
            model = 'gpt-5.4',
            temperature = 0.1, -- Lower = focused, higher = creative
            window = {
                layout = 'vertical',
                width = 0.4,
            },
            auto_insert_mode = true,
        },
    },
}
