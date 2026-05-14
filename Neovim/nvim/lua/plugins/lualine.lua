local M = {}

function M.config()
  -- Show git status.
  local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed
      }
    end
  end

  -- Get the current buffer's filetype.
  local function get_current_filetype()
    return vim.api.nvim_buf_get_option(0, 'filetype')
  end

  -- Get the current buffer's type.
  local function get_current_buftype()
    return vim.api.nvim_buf_get_option(0, 'buftype')
  end

  -- Get the buffer's filename.
  local function get_current_filename()
    local bufname = vim.api.nvim_buf_get_name(0)
    return bufname ~= '' and vim.fn.fnamemodify(bufname, ':t') or '[No Name]'
  end

  -- Gets the current buffer's filename with the filetype icon supplied
  -- by devicons.
  local Icon_hl_cache = {}
  local lualine_require = require('lualine_require')
  local modules = lualine_require.lazy_require {
    highlight = 'lualine.highlight',
    utils = 'lualine.utils.utils',
  }

  local FiletypeComponent = require('lualine.components.filetype'):extend()

  -- Return the current buffer's filetype icon with highlighting.
  function FiletypeComponent:get_current_filetype_icon()
    local icon, icon_highlight_group
    local _, devicons = pcall(require, 'nvim-web-devicons')
    local f_name, f_extension = vim.fn.expand('%:t'), vim.fn.expand('%:e')
    f_extension = f_extension ~= '' and f_extension or vim.bo.filetype
    icon, icon_highlight_group = devicons.get_icon(f_name, f_extension)

    if icon == nil and icon_highlight_group == nil then
      icon = ''
      icon_highlight_group = 'DevIconDefault'
    end

    local highlight_color = modules.utils.extract_highlight_colors(icon_highlight_group, 'fg')
    if highlight_color then
      local default_highlight = self:get_default_hl()
      local icon_highlight = Icon_hl_cache[highlight_color]
      if not icon_highlight or not modules.highlight.highlight_exists(icon_highlight.name .. '_normal') then
        icon_highlight = self:create_hl({ fg = highlight_color }, icon_highlight_group)
        Icon_hl_cache[highlight_color] = icon_highlight
      end
      icon = self:format_hl(icon_highlight) .. icon .. default_highlight
    end

    return icon
  end

  -- Return the current buffer's filename with the filetype icon.
  function FiletypeComponent:get_current_filename_with_icon()
    local icon = FiletypeComponent.get_current_filetype_icon(self)
    local f_name = get_current_filename()

    local readonly = vim.api.nvim_buf_get_option(0, 'readonly')
    local modifiable = vim.api.nvim_buf_get_option(0, 'modifiable')
    local nofile = get_current_buftype() == 'nofile'
    if readonly or nofile or not modifiable then
        f_name = f_name .. ' '
    end

    return icon .. ' ' .. f_name .. ' '
  end

  -- Get the lsp of the current buffer, when using native lsp.
  local function get_native_lsp()
    local buf_ft = get_current_filetype()
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
      return 'None'
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return 'None'
  end

  local c = {
    orange = '#E69875',
    yellow = 'yellow',
    git = {
      add = '#E66868',
      change = '#708089',
      delete = '#93B259',
    },
    black = '#232A2E',
  }

  local lualine = require("lualine")
  lualine.setup {
    sections = {
      lualine_a = {
        { 'mode' },
      },
      lualine_b = {
        { FiletypeComponent.get_current_filename_with_icon },
      },
      lualine_c = {
        {
          'branch',
          icon = { '', color = { fg = c.orange, gui = 'bold' } },
          separator = ' ',
        },
        {
          'diff',
          colored = true,
          source = diff_source,
          symbols = { added = ' ', modified = ' ', removed = ' ' },
        },
      },
      lualine_x = {
        'searchcount',
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          separator = '',
          diagnostics_color = {
            error = { gui = 'bold' },
            warn  = { gui = 'bold' },
            info  = { gui = 'bold' },
            hint  = { gui = 'bold' },
          },
          symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
          colored = true,
        },
        { 'encoding' },
        { 'fileformat' },
      },
      lualine_y = {
        {
          get_native_lsp,
          icon = { '', align = 'left', color = { fg = c.orange, gui = 'bold' } },
        },
      },
      lualine_z = {
        {
          'location',
          icon = { '', align = 'left', color = { fg = c.black } },
        },
        {
          'progress',
          icon = { '', align = 'left', color = { fg = c.black } },
        },
      },
    },
    options = {
      disabled_filetypes = { "dashboard" },
      globalstatus = true,
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
      theme = "auto",
    },
    extensions = {
      "toggleterm",
      "nvim-tree"
    }
  }
end

return M
