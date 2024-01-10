return {
  'neovim/nvim-lspconfig',
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local opts = { noremap=true, silent=true }
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    vim.keymap.set('n', '<leader>o', '<cmd>TypescriptOrganizeImports<cr>')
    vim.keymap.set('n', '<leader>a', '<cmd>TypescriptAddMissingImports<cr>')

    vim.diagnostic.config({
      virtual_text = false, -- disable virtual text
      severity_sort = true,
      underline = true,
      signs = true,
      update_in_insert = false,
      float = {
        -- source = "always",
        format = function(diagnostic)
          if diagnostic.source == 'eslint' or diagnostic.source == 'eslint_d' then
            return string.format(
              '%s %s(%s)',
              diagnostic.message,
              diagnostic.source,
              -- shows the name of the rule
              -- diagnostic.user_data.lsp.code
              diagnostic.code
            )
          end
          return string.format('%s [%s]', diagnostic.message, diagnostic.source)
        end,
      }
    })

    local signs = { Error = "", Warn = "", Hint = "", Info = "" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
  end
}
