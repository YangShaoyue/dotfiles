return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local actions = require('telescope.actions')
    require('nvim-web-devicons').setup({
      override = {},
      default = true
    })
    local builtin = require('telescope.builtin')
    local telescope = require('telescope')

    vim.keymap.set('n', '<leader>f', builtin.find_files, {})
    vim.keymap.set('n', '<leader>g', builtin.live_grep, {})

    telescope.setup({
      defaults = {
        -- path_display = { 'smart' },
        file_ignore_patterns = {
          "node_modules", "builder", "dist"
        },
        -- config_key = value,
        mappings = {
          i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            ["<C-h>"] = "which_key"
          }
        }
      },
      pickers = {
        find_files = {
          hidden = true
        }
      }
    })
  end
}
