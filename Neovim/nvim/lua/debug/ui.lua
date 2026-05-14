local M = {}

function M.config()
  local dap, dapui = require("dap"), require("dapui")
  dapui.setup({})

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
  end

  vim.keymap.set('n', '<leader>ui', dapui.toggle)

  local dap_breakpoint_color = {
    breakpoint = {
      ctermbg = 0,
      fg = '#cc1200',
      bg = '#31353f',
    },
    logpoing = {
      ctermbg = 0,
      fg = '#0012cc',
      bg = '#31353f',
    },
    stopped = {
      ctermbg = 0,
      fg = '#12cc00',
      bg = '#31353f'
    },
  }

  vim.api.nvim_set_hl(0, 'DapBreakpoint', dap_breakpoint_color.breakpoint)
  vim.api.nvim_set_hl(0, 'DapLogPoint', dap_breakpoint_color.logpoing)
  vim.api.nvim_set_hl(0, 'DapStopped', dap_breakpoint_color.stopped)

  local dap_breakpoint = {
    error = {
      text = "",
      texthl = "DapBreakpoint",
      linehl = "DapBreakpoint",
      numhl = "DapBreakpoint",
    },
    condition = {
      text = 'ﳁ',
      texthl = 'DapBreakpoint',
      linehl = 'DapBreakpoint',
      numhl = 'DapBreakpoint',
    },
    rejected = {
      text = "",
      texthl = "DapBreakpint",
      linehl = "DapBreakpoint",
      numhl = "DapBreakpoint",
    },
    logpoint = {
      text = '',
      texthl = 'DapLogPoint',
      linehl = 'DapLogPoint',
      numhl = 'DapLogPoint',
    },
    stopped = {
      text = '',
      texthl = 'DapStopped',
      linehl = 'DapStopped',
      numhl = 'DapStopped',
    },
  }

  vim.fn.sign_define('DapBreakpoint', dap_breakpoint.error)
  vim.fn.sign_define('DapBreakpointCondition', dap_breakpoint.condition)
  vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)
  vim.fn.sign_define('DapLogPoint', dap_breakpoint.logpoint)
  vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)

  require("nvim-dap-virtual-text").setup {
    enabled = true,
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = false,
    show_stop_reason = true,
    commented = false,
    only_first_definition = true,
    all_references = false,
    display_callback = function(variable, _buf, _stackframe, _node)
      return variable.name .. ' = ' .. variable.value
    end,
    virt_text_pos = 'eol',
    all_frames = false,
    virt_lines = false,
    virt_text_win_col = nil
  }
end

return M
