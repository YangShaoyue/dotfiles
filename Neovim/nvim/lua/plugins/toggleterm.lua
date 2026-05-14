local M = {}

function M.config()
  local toggleterm = require("toggleterm")

  toggleterm.setup({
    direction = 'float',
    open_mapping = [[<c-\>]],
  })
end

return M
