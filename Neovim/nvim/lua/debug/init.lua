local M = {}
local _loaded = false

function M.setup()
  if _loaded then return end
  _loaded = true

  -- Packadd all DAP plugins (they were registered with load=function() end)
  vim.cmd.packadd("nvim-dap")
  vim.cmd.packadd("nvim-dap-ui")
  vim.cmd.packadd("nvim-dap-vscode-js")
  vim.cmd.packadd("nvim-dap-virtual-text")
  -- vscode-js-debug is a CLI tool dependency, not a Lua module

  -- Apply DAP configurations
  require("debug.javascript").config()
  require("debug.ui").config()
end

return M
