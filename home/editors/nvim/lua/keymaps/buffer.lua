return {
  -- TIP: Disable arrow keys in normal mode
  vim.keymap.set('n', '<leader>k', '<cmd>bn<CR>', { desc = 'Next buffer' }),
  vim.keymap.set('n', '<leader>j', '<cmd>bp<CR>', { desc = 'Prev buffer' }),
  vim.keymap.set('n', '<leader>x', '<cmd>bd<CR>', { desc = 'Kill buffer' }),
}
