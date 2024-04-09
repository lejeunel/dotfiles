local ignore_which_key_opts = { noremap = true, silent = true, desc = 'which_key_ignore' }

-- basic telescope configuration
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end
  local conf = require('telescope.config').values

  require('telescope.pickers')
    .new({}, {
      prompt_title = 'Harpoon',
      finder = require('telescope.finders').new_table {
        results = file_paths,
      },
      previewer = conf.file_previewer {},
      sorter = conf.generic_sorter {},
    })
    :find()
end

return {
  'theprimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    require('harpoon'):setup()
  end,
  vim.keymap.set('n', '<leader>a', function()
    toggle_telescope(require('harpoon'):list())
  end, { desc = 'Open harpoon window' }),
  vim.keymap.set('n', '<leader>A', function()
    require('harpoon'):list():add()
  end, ignore_which_key_opts),
  vim.keymap.set('n', '<leader>1', function()
    require('harpoon'):list():select(1)
  end, ignore_which_key_opts),
  vim.keymap.set('n', '<leader>2', function()
    require('harpoon'):list():select(2)
  end, ignore_which_key_opts),
  vim.keymap.set('n', '<leader>3', function()
    require('harpoon'):list():select(3)
  end, ignore_which_key_opts),
  vim.keymap.set('n', '<leader>4', function()
    require('harpoon'):list():select(4)
  end, ignore_which_key_opts),
}
