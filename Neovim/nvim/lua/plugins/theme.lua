-- everforest --
-- vim.g.everforest_diagnostic_line_highlight = 1
-- vim.g.everforest_background = 'hard'
-- vim.g.everforest_enable_italic = 1
-- vim.cmd('colorscheme everforest')

require('noirbuddy').setup {
  -- preset = 'minimal',
  -- preset = 'miami-nights',
  -- preset = 'kiwi',
  preset = 'slate',
  -- preset = 'crt-green',
  -- preset = 'crt-amber',
  -- preset = 'christmas',
  -- preset = '',
  -- styles = {
  --   italic = true,
  --   bold = false,
  --   underline = false,
  --   undercurl = true,
  -- },
  colors = {
    -- background = '#1C1C1C',
    -- background = '#212121',
    noir_0 = '#8B81C3',
    -- primary = '#6A4C9C',
    -- primary = '#8F77B5',
    -- secondary = '#8F5A3C',
    -- noir_1 = '#BDC0BA',
    --
    -- -- noir_0 = '#f5f5f5',
    --
    -- noir_0 = '#d5d5d5',
    --
    -- noir_2 = '#b4b4b4',
    --
    -- noir_3 = '#a7a7a7',
    --
    -- noir_5 = '#828282',
    --
    -- noir_4 = '#949494',
    --
    -- noir_6 = '#535353',
    --
    -- noir_7 = '#737373',
    --
    -- noir_8 = '#323232',
    --
    -- noir_9 = '#212121',
  }
}

-- vim.fn.sign_define({
--   {
--     name = 'DiagnosticSignError',
--     text = 'E',
--     texthl = 'DiagnosticSignError',
--     linehl = 'ErrorLine'
--   },
--   {
--     name = 'DiagnosticSignWarn',
--     text = 'W',
--     texthl = 'DiagnosticSignWarn',
--     linehl = 'WarningLine'
--   },
--   {
--     name = 'DiagnosticSignInfo',
--     text = 'I',
--     texthl = 'DiagnosticSignInfo',
--     linehl = 'InfoLine'
--   },
--   {
--     name = 'DiagnosticSignHint',
--     text = 'H',
--     texthl = 'DiagnosticSignHint',
--     linehl = 'HintLine'
--   },
-- })
