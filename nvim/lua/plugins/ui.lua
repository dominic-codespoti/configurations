return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>fb", function() require("telescope.builtin").buffers() end },
            { "<leader>fh", function() require("telescope.builtin").help_tags() end },
            { "<leader>ff", function() require("telescope.builtin").find_files() end },
            { "<leader>fw", function() require("telescope.builtin").live_grep() end },
            { "<leader>fe", function() require("telescope.builtin").diagnostics() end },
        },
        opts = function ()
            return require("plugins.configs.telescope")
        end,
        config = function (_, opts)
            require("telescope").setup(opts)
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        init = function() vim.g.neo_tree_remove_legacy_commands = true end,
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
        keys = {
            { "<leader>o", ":Neotree filesystem focus left<CR>" }
        },
        opts = function ()
            return require("plugins.configs.neotree")
        end,
        config = function (_, opts)
            require("neo-tree").setup(opts)
        end
    },
    {
        "goolord/alpha-nvim",
        priority = 1000,
        lazy = false,
        cmd = "Alpha",
        config = function ()
            local opts = require("plugins.configs.alpha")
            require("alpha").setup(opts)
        end
    },
    {
        "voldikss/vim-floaterm",
        lazy = true,
        keys = {
            { "<leader>tt", ":FloatermToggle<CR>" },
            { "<leader>tt", "<C-\\><C-n>:FloatermToggle<CR>", mode = "t" },
        }
    },
    {
        'romgrk/barbar.nvim',
        lazy = false,
        keys = {
            { "<S-Tab>", "<Cmd>BufferPrevious<CR>" },
            { "<Tab>", "<Cmd>BufferNext<CR>" },
        },
    }
}
