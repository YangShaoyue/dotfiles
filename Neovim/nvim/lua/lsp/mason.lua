local M = {}

function M.config()
  local capabilities = require('blink.cmp').get_lsp_capabilities()

  local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', bufopts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>d', '<cmd>Telescope lsp_document_symbols<cr>', bufopts)
    vim.keymap.set('n', '<leader>ll', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<leader>lk', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', '<leader>lj', vim.diagnostic.goto_next, bufopts)
  end

  local lsp_config = {
    capabilities = capabilities,
    on_attach = function(_, bufnr)
      on_attach(_, bufnr)
    end
  }

  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")

  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })

  mason_lspconfig.setup({
    ensure_installed = {
      "lua_ls",
      "cssls",
      "emmet_ls",
      "html",
      "jsonls",
      "pyright",
      "yamlls",
      'ts_ls',
      'graphql',
      'rust_analyzer'
    },
    automatic_installation = true,
    handlers = {
      function(server_name)
        require('lspconfig')[server_name].setup(lsp_config)
      end,
      lua_ls = function()
        require('lspconfig').lua_ls.setup(vim.tbl_extend('force', lsp_config, {
          settings = {
            Lua = {
              diagnostics = {
                globals = {'vim'}
              }
            }
          }
        }))
      end,
      ts_ls = function()
        require('lspconfig').ts_ls.setup({
          server = vim.tbl_extend('force', lsp_config, {
            on_attach = function(_, bufnr)
              on_attach(_, bufnr)
            end,
            init_options = {
              preferences = {
                importModuleSpecifierPreference = 'project-relative',
                jsxAttributeCompletionStyle = 'none'
              }
            }
          })
        })
      end
    }
  })
end

return M
