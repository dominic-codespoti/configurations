return {
    {
        "folke/neodev.nvim",
        lazy = true,
        event = "BufEnter",
        opts = {}
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        build = ":MasonUpdate",
        config = function ()
            require("mason").setup()
        end,
        dependencies = {
            {
                "jay-babu/mason-nvim-dap.nvim",
                priority = 200,
            }
        }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        config = function ()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { "c", "c_sharp", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "bash", "haskell" },
                highlight = {
                    enable = true,
                    disable = function(_, bufnr) return vim.api.nvim_buf_line_count(bufnr) > 10000 end,
                },
                incremental_selection = { enable = true },
                indent = { enable = true },
                autotag = { enable = true },
                context_commentstring = { enable = true, enable_autocmd = false },
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            require "plugins.configs.lspconfig"
        end,
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                priority = 200,
                cmd = { "LspInstall", "LspUninstall" },
                config = function ()
                    require("mason-lspconfig").setup({
                        ensure_installed = { "lua_ls", "rust_analyzer", "csharp_ls", "vtsls", "terraformls", "bashls", "azure_pipelines_ls", "marksman", "powershell_es", "yamlls", "bicep" },
                    })

                    require("mason-lspconfig").setup_handlers {
                        function (server_name) -- default handler (optional)
                            require("lspconfig")[server_name].setup {}
                        end,
                    }
                end
            },
        }
    },
    {
        "nvimtools/none-ls.nvim",
        main = "null-ls",
        lazy = true,
        event = "BufEnter",
        dependencies = {
            {
                "nvimtools/none-ls-extras.nvim",
                "jay-babu/mason-null-ls.nvim",
                dependencies = { "williamboman/mason.nvim" },
                priority = 200,
                cmd = { "NullLsInstall", "NullLsUninstall" },
                opts = { handlers = {} },
            },
        },
        config = function ()
          local null_ls = require("null-ls")
          null_ls.setup({
            sources = {
              require("none-ls.diagnostics.eslint_d"),
            }
          })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        commit = "a9c701fa7e12e9257b3162000e5288a75d280c28",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets" },
                opts = { history = true, updateevents = "TextChanged,TextChangedI" },
                config = function(_, opts)
                    local setup = require("plugins.configs.luasnip")
                    setup(opts)
                end,
            },
            {
                "zbirenbaum/copilot.lua",
                cmd = "Copilot auth",
                config = function()
                    require("copilot").setup({
                        suggestion = {enabled = false},
                        panel = {enabled = false},
                    })
                end,
            },
            {
                "zbirenbaum/copilot-cmp",
                config = function ()
                    require("copilot_cmp").setup()
                end
            },
        },
        event = "BufEnter",
        opts = function()
            local cmp = require "cmp"
            local snip_status_ok, luasnip = pcall(require, "luasnip")
            local lspkind_status_ok, lspkind = pcall(require, "lspkind")
            if not snip_status_ok then return end
            local border_opts = {
                border = "single",
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            }

            local function has_words_before()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
            end

            return {
                enabled = true,
                preselect = cmp.PreselectMode.None,
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = lspkind_status_ok and lspkind.cmp_format({
                        mode = "symbol",
                        max_width = 50,
                        symbol_map = { Copilot = "" }
                    }),
                },
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                duplicates = {
                    nvim_lsp = 1,
                    luasnip = 1,
                    cmp_tabnine = 1,
                    buffer = 1,
                    path = 1,
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                window = {
                    completion = cmp.config.window.bordered(border_opts),
                    documentation = cmp.config.window.bordered(border_opts),
                },
                mapping = {
                    ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
                    ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
                    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable,
                    ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
                    ["<CR>"] = cmp.mapping.confirm { select = false },
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sources = cmp.config.sources {
                    { name = "copilot", priority = 1250 },
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "luasnip", priority = 750 },
                    { name = "buffer", priority = 500 },
                    { name = "path", priority = 250 },
                },
            }
        end,
    },
    {
        "mfussenegger/nvim-dap",
    },
}
