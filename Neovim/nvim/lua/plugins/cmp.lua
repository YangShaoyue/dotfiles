local M = {}

function M.config()
  require("blink.cmp").setup({
    keymap = {
      preset = 'enter',

      -- Custom overrides to preserve your keybinding habits
      ['<Tab>'] = {
        function(cmp)
          if cmp.is_visible() then
            return cmp.select_next()
          elseif cmp.snippet_active() then
            return cmp.snippet_forward()
          end
        end,
        'fallback',
      },
      ['<S-Tab>'] = {
        function(cmp)
          if cmp.is_visible() then
            return cmp.select_prev()
          elseif cmp.snippet_active() then
            return cmp.snippet_backward()
          end
        end,
        'fallback',
      },

      ['<C-d>'] = { 'snippet_forward', 'fallback' },
      ['<C-b>'] = { 'snippet_backward', 'fallback' },

      ['<C-c>'] = { 'hide', 'fallback' },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  })
end

return M
