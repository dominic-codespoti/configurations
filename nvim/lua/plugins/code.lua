return {
    {
        "f-person/git-blame.nvim",
    },
    {
        'echasnovski/mini.comment',
        version = '*'
    },
    {
        'echasnovski/mini.pairs',
        version = '*'
    },
    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        cmd = "Copilot auth",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({})
        end,
    },
    {
        "nvim-neotest/neotest",
        lazy = true,
        dependencies = {
            'https://github.com/Issafalcon/neotest-dotnet',
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim"
        }
    },
    {
        "zbirenbaum/copilot-cmp",
        lazy = true
    }
}
