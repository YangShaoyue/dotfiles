return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- import lspconfig plugin
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(_, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', bufopts)
      vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<leader>d', '<cmd>Telescope lsp_document_symbols<cr>', bufopts)
      -- show diagnostic info in popup window
      vim.keymap.set('n', '<leader>ll', vim.diagnostic.open_float, bufopts)
      vim.keymap.set('n', '<leader>lk', vim.diagnostic.goto_prev, bufopts)
      vim.keymap.set('n', '<leader>lj', vim.diagnostic.goto_next, bufopts)
      -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ll', '<cmd>lua vim.diagnostic.open_float()<CR>', bufopts)
    end
    local lsp_config = {
      capabilities = capabilities,
      on_attach = function(_, bufnr)
        -- vim.api.nvim_create_autocmd("CursorHold", {
        --   buffer = bufnr,
        --   callback = function()
        --     local opts = {
        --       focusable = false,
        --       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        --       border = 'rounded',
        --       source = 'always',
        --       prefix = ' ',
        --       scope = 'cursor',
        --     }
        --     vim.diagnostic.open_float(nil, opts)
        --   end
        -- })
        on_attach(_, bufnr)
      end
    }
    -- import mason
    local mason = require("mason")
    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")
    -- enable mason and configure icons
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
        'tsserver',
        'graphql',
        'rust_analyzer'
      },
      automatic_installation = true,
    })
    mason_lspconfig.setup_handlers({
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
      tsserver = function()
        capabilities = capabilities
        on_attach = on_attach
        -- require('typescript').setup({
        --   server = vim.tbl_extend('force', lsp_config, {
        --     on_attach = function(_, bufnr)
        --       on_attach(_, bufnr)
        --     end,
        --     init_options = {
        --       preferences = {
        --         importModuleSpecifierPreference = 'project-relative',
        --         jsxAttributeCompletionStyle = 'none'
        --       }
        --     }
        --   })
        -- })
      end
    })
  end
}
