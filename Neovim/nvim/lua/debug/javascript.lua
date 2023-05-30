--
-- debugger_path: If you're using anything else than packer to install plugins you need to modify the debugger_path because the path might change depending on your plugin manager, for lazy, you need to change the debugger_path to be: vim.fn.stdpath('data') .. "/lazy/vscode-js-debug"
-- adapters: I needed to add chrome and node to the list of default adapters because I wanted to be able to use the configuration I have in VSCode in my Neovim, and VS Code refers to this adapter as just node and chrome instead of node-pwa and chrome-pwa
--
require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = vim.fn.stdpath('data') .. "/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

for _, language in ipairs(js_based_languages) do
  require("dap").configurations[language] = {
    {
      name = "Electron Debug Main Process",
      type = "pwa-node",
      request = "launch",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "${workspaceFolder}/node_modules/.bin/electron",
      windows = {
        runtimeExecutable = "${workspaceFolder}/node_modules/.bin/electron.cmd",
      },
      program = "${workspaceFolder}/dist/main/index.cjs",
      protocol ="inspector"
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require 'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Start Chrome with \"localhost\"",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
    }
  }
end
