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
