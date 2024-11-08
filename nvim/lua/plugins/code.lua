return {
    {
        "f-person/git-blame.nvim",
        lazy = true,
        keys = {
            { "<leader>gb", ":GitBlameToggle<CR>" }
        },
        config = function ()
            require("gitblame").setup({})
        end
    },
    {
        'echasnovski/mini.comment',
        version = '*',
        config = function ()
            require('mini.comment').setup({
                options = {
                    ignore_blank_line = false,
                    start_of_line = false,
                    pad_comment_parts = true,
                },

                mappings = {
                    comment = 'gc',
                    comment_line = 'gcc',
                    textobject = 'gc',
                },

                hooks = {
                    pre = function() end,
                    post = function() end,
                },
            })

        end
    },
    {
        'echasnovski/mini.pairs',
        version = '*'
    },
    {
        "FotiadisM/tabset.nvim",
        config = function()
            require("tabset").setup({
                defaults = {
                    tabwidth = 4,
                    expandtab = true
                },
                languages = {
                    {
                        filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "yaml" },
                        config = {
                            tabwidth = 2
                        }
                    }
                }
            })
        end
    },
    {
        "nvim-neotest/neotest",
        lazy = true,
        dependencies = {
            'https://github.com/Issafalcon/neotest-dotnet',
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim"
        },
        keys = {
            { "<leader>tr", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>" },
            { "<leader>ts", ":lua require('neotest').summary.toggle()<CR>" },
        },
        config = function ()
            require("neotest").setup({
                adapters = {
                    require("neotest-dotnet")
                }
            })
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = function ()
            return require("plugins.configs.indentline")
        end,
        config = function (_, opts)
            require("ibl").setup(opts)
        end
    },
    {
        "Hoffs/omnisharp-extended-lsp.nvim",
        lazy = true
    }
}
