local M = {}

function M.config()
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
      file_ignore_patterns = {
        "node_modules", "builder", "dist"
      },
      mappings = {
        i = {
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

return M
