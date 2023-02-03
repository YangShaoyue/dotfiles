local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- vim.g.mapleader = ' '
-- vim.g.maplocalleader = ' '

require('lazy').setup({
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    -- tag = 'nightly' -- optional, updated every week. (see issue #1193)
  },

  'sainnhe/everforest',

  'windwp/nvim-autopairs',
  'mg979/vim-visual-multi',
  'tpope/vim-surround',

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
  },

  {
    'nvim-telescope/telescope.nvim', version = '0.1.0',
  -- or                            , branch = '0.1.x',
     dependencies = { {'nvim-lua/plenary.nvim'} }
  },

  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'onsails/lspkind-nvim',

  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  'rafamadriz/friendly-snippets',

  'jose-elias-alvarez/typescript.nvim',
  'jose-elias-alvarez/null-ls.nvim',
  'nvim-treesitter/nvim-treesitter',

  'windwp/nvim-ts-autotag',
  'axelvc/template-string.nvim',
  'numToStr/Comment.nvim',
  {
    'akinsho/toggleterm.nvim', version = '*'
  },

  -- {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

  'gpanders/editorconfig.nvim',
  'lewis6991/gitsigns.nvim',

  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" },
  },

  -- {'akinsho/bufferline.nvim', version = "v3.*", dependencies = 'nvim-tree/nvim-web-devicons'},
  'norcalli/nvim-colorizer.lua',
})
