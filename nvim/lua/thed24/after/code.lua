-- Comments
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

-- Pairs
require('mini.pairs').setup()

-- Git
vim.api.nvim_set_keymap('n', '<leader>gb', ':GitBlameToggle<CR>', {noremap = true, silent = true})

-- Copilot
require('copilot').setup({
    suggestion = {enabled = false},
    panel = {enabled = false},
})

require('copilot_cmp').setup()

-- Testing
require("neotest").setup({
  adapters = {
    require("neotest-dotnet")
  }
})

vim.api.nvim_set_keymap('n', '<leader>tr', ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ts', ':lua require("neotest").summary.toggle()<CR>', {noremap = true, silent = true})
