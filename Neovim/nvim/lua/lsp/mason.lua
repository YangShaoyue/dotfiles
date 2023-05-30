require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- mason-lspconfig uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
require("mason-lspconfig").setup({
  -- ensure_installed = {
  --   "sumneko_lua",
  --   "cssls",
  --   "emmet_ls",
  --   "html",
  --   "jsonls",
  --   "pyright",
  --   "yamlls",
  --   'tsserver',
  --   'graphql',
  --   'rust_analyzer'
  -- },
  automatic_installation = true,
})
