-- Neo Tree
require("neo-tree").setup({
    window = {
        position = "left",
        width = 40,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
    },
    close_if_last_window = true,
    filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
    },
    event_handlers = {
        {
            event = "neo_tree_buffer_enter",
            handler = function(_) vim.opt_local.signcolumn = "auto" end,
        },
    }
})

vim.api.nvim_set_keymap('n', '<leader>o', ':Neotree filesystem focus left<CR>', {noremap = true, silent = true})

-- Telescope
require('telescope').setup({
    defaults = {
        vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    }
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fe', builtin.diagnostics, {})

-- Float Term
vim.api.nvim_set_keymap('n', '<leader>t', ':FloatermToggle<CR>', { silent = true })
vim.api.nvim_set_keymap('t', '<leader>t', '<C-\\><C-n>:FloatermToggle<CR>', { silent = true })

-- Startup
local startup = function()
    local dashboard = require'alpha.themes.dashboard'

    dashboard.section.header.val = {
        "                                                  /#&@@@@@@@@@@@@#&,",
        "                                            @@@@@*........,........,@@@@@%",
        "                                        @@@%.,.,...,,.,...,.,,,,,,,,,....(@@@&",
        "                                     @@@,..............,,,,,.,,,,,,,,,,,,....@@@.",
        "                                   @@(.,,..........,..,,,,,..,,,,,,,,,,,...,...,@@(",
        "                                 @@/.....................,.,,,.,.,,,,,,,,,,,.....,@@",
        "                                @@...,...............,......,,....,.,.,............@@*",
        "                              .@@..........................................&*.......%@(                                 ",
        "                              @@...........&@@@@............ ............@@@@@(......@@",
        "                             @@,...........@@@@@,.....&@@(/*******/(&@&..,@@@(.......,@@",
        "                            &@#....................@/******,,,*,,,,,,,**&#..,.........@@",
        "                            @@...................&@&@@@%#((((((((((((((((@............,@@",
        "                            @@...................,@#(/(((((((((((((//((@(..............@@@@&",
        "                          @@&.........................,%@@@@@@@@@&/,.................../@..@@@",
        "                        @@#.............................................................@,.../@@.",
        "                       @@...............................................................@*.....%@@",
        "                      @@...................................,&@@@@@@.....................@@......,@@",
        "                     &@...................... ...%@@@@&@,,,,,,,,,,@.....................@@.......(@*",
        "                     &@,..........@@#,*@@@@@&,,,,,,,,,,,,,,,,,,,.@@.....................&@@......,@@",
        "                      @@........(@(%.,,,,,,,,,,,,,,,,,,,,,,,,,,.@@......................#@@@@@...@@",
        "                      @@@.......@(%% .,,,,,,,,,,,,,,,,,,,,,,..&@,.......................@@%    *",
        "                      &@(@@..../#/%/@.@..,,,,,,,,,,........@@@,...........,.............@@.",
        "                       @@@@@@@@,........#@@@@@@@@@@@@@@&/,..............................@@",
        "                              @@........................................................@@",
        "                              &@,......................................................@@",
        "                               &@,...................................................&@@",
        "                                 &@,...............................................@@@@@",
        "                                   @@@,........................................(@&(((#&@@",
        "                                 (@%((((%@@,............................ .@@@##(((((@@",
        "                                   &&@@(((((((#@@@@@@#*,,....,*%@@@@@@@@&((((@@@@@@@,",
        "                                      &@@@@@@@@(,#@@#                   &@@@#",
        "",
    }

    dashboard.section.buttons.val = {
        dashboard.button( "e", "New file" , ":ene <BAR> startinsert <CR>"),
        dashboard.button( "f", "Search" , ":Telescope fd <CR>"),
        dashboard.button( "q", "Quit NVIM" , ":qa<CR>"),
    }

    return dashboard
end

require("alpha").setup(startup().config)

-- Tabline
vim.api.nvim_set_keymap('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Tab>', '<Cmd>BufferNext<CR>', { silent = true})
