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
    local harpoon = require 'harpoon'
    harpoon:setup {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    }
    vim.keymap.set('n', '<leader>rr', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = '[M]enu' })
    vim.keymap.set('n', '<leader>ra', function()
      require('harpoon'):list():add()
    end, { desc = '[A]dd' })
    vim.keymap.set('n', '<leader>1', function()
      require('harpoon'):list():select(1)
    end, ignore_which_key_opts)
    vim.keymap.set('n', '<leader>2', function()
      require('harpoon'):list():select(2)
    end, ignore_which_key_opts)
    vim.keymap.set('n', '<leader>3', function()
      require('harpoon'):list():select(3)
    end, ignore_which_key_opts)
    vim.keymap.set('n', '<leader>4', function()
      require('harpoon'):list():select(4)
    end, ignore_which_key_opts)
  end,
}
