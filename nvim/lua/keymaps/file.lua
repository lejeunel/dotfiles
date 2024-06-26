return {
  -- TIP: Disable arrow keys in normal mode
  vim.keymap.set('n', '<leader>fs', '<cmd>w<CR>', { desc = '[F]ile [S]ave' }),
  vim.keymap.set('n', '<leader>fa', '<cmd>wa<CR>', { desc = '[F]ile Save [A]ll' }),
  vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = '[E]xplore' }),
}
