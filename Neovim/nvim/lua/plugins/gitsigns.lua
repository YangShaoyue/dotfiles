local M = {}

function M.config()
  local gitsigns = require("gitsigns")

  gitsigns.setup({
    signs = {
      add          = { text = '+' },
      change       = { text = '│' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
  })
end

return M
