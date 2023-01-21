local opt = vim.opt

opt.number = true
-- opt.relativenumber = true

-- Tab set to 2 spaces
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true

vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

opt.scrolloff = 5
opt.sidescrolloff = 5

opt.swapfile = false
opt.autoread = true
vim.bo.autoread = true

opt.signcolumn = 'yes'
opt.list = true

-- set termguicolors to enable highlight groups
opt.cursorline = true
opt.termguicolors = true

opt.ignorecase = true
opt.smartcase = true

-- system clipboard
opt.clipboard:append('unnamedplus')

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 300
    })
  end
})
