return {
    {
        "nvim-telescope/telescope.nvim",
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
            { "<leader>tn", "<C-\\><C-n>:FloatermNew<CR>", mode = "t" },
            { "<leader>t<Tab>", "<C-\\><C-n>:FloatermNext<CR>", mode = "t" },
        },
        init = function ()
            local is_windows = package.config:sub(1,1) == '\\'
            if is_windows then
                vim.g.floaterm_shell = 'powershell'
            end
        end
    },
    {
        'romgrk/barbar.nvim',
        lazy = false,
        keys = {
            { "<S-Tab>", "<Cmd>BufferPrevious<CR>" },
            { "<Tab>", "<Cmd>BufferNext<CR>" },
            { "<S-W>", "<Cmd>BufferClose<CR>" },
        },
    }
}
