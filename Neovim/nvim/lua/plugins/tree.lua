return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional, for file icons
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      sort_by = "case_sensitive",
      actions = {
        -- open_file = { quit_on_open = true }
      },
      update_focused_file = {
        enable = true,
        update_cwd = true
      },
      filters = {
        dotfiles = false,
      },
      git = {
        enable = false
      },
      log = {
        enable = true,
        types = {
          diagnostics = true
        }
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        debounce_delay = 50,
        icons = {
          hint = 'H',
          info = 'I',
          warning = 'W',
          error = 'E'
        }
      }
    })

    vim.keymap.set('n', '<A-m>', '<cmd>NvimTreeToggle<cr>')
  end
}

