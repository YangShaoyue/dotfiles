-- ============================================================
-- Preamble: settings required before plugins load
-- ============================================================

-- Disable netrw before nvim-tree loads
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ============================================================
-- Plugin specifications in dependency order
-- ============================================================

local specs = {
  -- Foundation
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",

  -- Theme (load early)
  "https://github.com/sainnhe/everforest",

  -- Editing
  "https://github.com/tpope/vim-surround",
  "https://github.com/mg979/vim-visual-multi",
  "https://github.com/numToStr/Comment.nvim",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/axelvc/template-string.nvim",

  -- UI
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/norcalli/nvim-colorizer.lua",
  "https://github.com/gpanders/editorconfig.nvim",

  -- Git
  "https://github.com/lewis6991/gitsigns.nvim",

  -- Treesitter
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/windwp/nvim-ts-autotag",

  -- Navigation
  "https://github.com/folke/flash.nvim",

  -- File tree
  "https://github.com/nvim-tree/nvim-tree.lua",

  -- Telescope
  { src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.x" },

  -- Terminal
  { src = "https://github.com/akinsho/toggleterm.nvim", version = "v2.13.1" },

  -- Completion
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/saghen/blink.lib",
  { src = "https://github.com/saghen/blink.cmp", version = "main" },
  "https://github.com/onsails/lspkind-nvim",

  -- LSP
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
}

-- DAP plugins (lazy-loaded on first use via core/maps.lua debug triggers)
local dap_specs = {
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/mxsdev/nvim-dap-vscode-js",
  "https://github.com/theHamsta/nvim-dap-virtual-text",
  "https://github.com/microsoft/vscode-js-debug",
}

-- Install and load all eager plugins immediately
vim.pack.add(specs)

-- Install DAP plugins but do NOT load them (lazy)
vim.pack.add(dap_specs, { load = function() end })

-- Ensure all eager plugins are on the runtime path.
-- vim.pack.add() may skip packadd for already-installed plugins;
-- we prepend to rtp and also extend package.path as a fallback.
local opt_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt"
local eager_plugins = {
  "plenary.nvim",
  "nvim-web-devicons",
  "everforest",
  "vim-surround",
  "vim-visual-multi",
  "Comment.nvim",
  "nvim-autopairs",
  "template-string.nvim",
  "lualine.nvim",
  "nvim-colorizer.lua",
  "editorconfig.nvim",
  "gitsigns.nvim",
  "nvim-treesitter",
  "nvim-ts-autotag",
  "flash.nvim",
  "nvim-tree.lua",
  "telescope.nvim",
  "toggleterm.nvim",
  "friendly-snippets",
  "blink.lib",
  "blink.cmp",
  "lspkind-nvim",
  "nvim-lspconfig",
  "mason.nvim",
  "mason-lspconfig.nvim",
}

for _, name in ipairs(eager_plugins) do
  local plugin_path = opt_dir .. "/" .. name
  vim.opt.rtp:prepend(plugin_path)
  package.path = plugin_path .. "/lua/?.lua;" .. plugin_path .. "/lua/?/init.lua;" .. package.path
end

-- ============================================================
-- Apply plugin configurations in dependency order
-- ============================================================

require("plugins.theme").config()
require("plugins.surround").config()
require("plugins.visual-multi").config()
require("plugins.Comment").config()
require("plugins.autopairs").config()
require("plugins.template-string").config()
require("plugins.lualine").config()
require("plugins.colorizer").config()
require("plugins.editorconfig").config()
require("plugins.gitsigns").config()
require("plugins.treesitter").config()
require("plugins.flash").config()
require("plugins.tree").config()
require("plugins.telescope").config()
require("plugins.toggleterm").config()

-- blink.cmp: build native fuzzy library (non-fatal if build fails)
-- The build step copies the compiled dll to site/lib/, ensure it exists.
vim.fn.mkdir(vim.fn.stdpath("data") .. "/site/lib", "p")

-- Workaround for blink.cmp v2 Windows bug: cargo produces blink_cmp_fuzzy.dll
-- but the build script expects libblink_cmp_fuzzy.dll (Linux lib prefix).
local function fix_windows_dll_name()
  local target_dir = opt_dir .. "/blink.cmp/target/release"
  local src = target_dir .. "/blink_cmp_fuzzy.dll"
  local dst = target_dir .. "/libblink_cmp_fuzzy.dll"
  if vim.fn.filereadable(src) == 1 and vim.fn.filereadable(dst) == 0 then
    vim.fn.rename(src, dst)
    return true
  end
  return vim.fn.filereadable(dst) == 1
end

local ok, err = pcall(function()
  require("blink.cmp").build():wait(60000)
end)
if not ok then
  -- If build failed, try the Windows DLL name fix and re-run
  if fix_windows_dll_name() then
    pcall(function()
      require("blink.cmp").build():wait(60000)
    end)
  else
    vim.notify("blink.cmp: native build failed: " .. tostring(err), vim.log.levels.WARN)
  end
end

require("plugins.cmp").config()
require("plugins.lspkind").config()
require("lsp.config").config()
require("lsp.mason").config()

-- DAP is NOT configured here. It is lazy-loaded on first use
-- via require("debug").setup(), triggered by debug keymaps in core/maps.lua.
