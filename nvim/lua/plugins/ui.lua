return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        init = function() vim.g.neo_tree_remove_legacy_commands = true end,
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" }
    },
    {
        "goolord/alpha-nvim",
        cmd = "Alpha"
    },
    {
        "voldikss/vim-floaterm"
    },
    {
        'romgrk/barbar.nvim'
    }
}
