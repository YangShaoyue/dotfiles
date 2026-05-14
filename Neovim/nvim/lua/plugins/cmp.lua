-- blink.cmp 配置
return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = 'super-tab', -- 我们手动定义所有按键，避免冲突

      ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-c>'] = { 'hide', 'fallback' },
      ['<CR>'] = {
        function(cmp)
          if cmp.is_visible() and cmp.get_selected_item() then
            return cmp.accept()
          end
        end,
        'fallback',
      },
      -- Tab 键逻辑：如果补全可见则选下一个，如果能跳转 snippet 则跳转，否则 fallback
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

      -- 对应你原配置中的 <c-d> 和 <c-b> 的 Luasnip 跳转逻辑
      -- blink 会自动检测你配置的 snippet 引擎
      ['<C-d>'] = { 'snippet_forward', 'fallback' },
      ['<C-b>'] = { 'snippet_backward', 'fallback' },

      -- 其他常用导航
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },
    },
   appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
