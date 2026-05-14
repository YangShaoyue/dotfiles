local M = {}

function M.config()
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

  vim.keymap.set('n', '<leader>o', '<cmd>TypescriptOrganizeImports<cr>')
  vim.keymap.set('n', '<leader>a', '<cmd>TypescriptAddMissingImports<cr>')

  vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    underline = true,
    signs = true,
    update_in_insert = false,
  })

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = "",
      },
      texthl = {
        [vim.diagnostic.severity.ERROR] = "Error",
        [vim.diagnostic.severity.WARN] = "Warn",
        [vim.diagnostic.severity.HINT] = "Hint",
        [vim.diagnostic.severity.INFO] = "Info",
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
      },
    },
  })
end

return M
