return {
  -- everforest --
  'sainnhe/everforest',
  config = function()
    vim.g.everforest_diagnostic_line_highlight = 1
    vim.g.everforest_background = 'hard'
    vim.g.everforest_enable_italic = 1
    vim.cmd('colorscheme everforest')
  end
}
