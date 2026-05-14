local M = {}

function M.config()
  local templateString = require("template-string")

  templateString.setup({
    filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'python' },
    jsx_brackets = true,
    remove_template_string = false,
    restore_quotes = {
      normal = [[']],
      jsx = [["]],
    },
  })
end

return M
