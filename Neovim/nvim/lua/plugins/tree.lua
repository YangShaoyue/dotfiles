local M = {}

function M.config()
  local nvimtree = require("nvim-tree")

  nvimtree.setup({
    sort_by = "case_sensitive",
    actions = {},
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

return M
