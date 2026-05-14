local M = {}

function M.config()
  local treesitter = require("nvim-treesitter.config")

  treesitter.setup({
    ensure_installed = { "tsx", "lua", "rust", "javascript", "html", "json", "graphql", "regex", "vim", "css" },
    sync_install = false,
    auto_install = false,
    highlight = {
      enable = true,
      disable = {},
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
      disbale = {}
    },
    autotag = {
      enable = true
    }
  })
end

return M
