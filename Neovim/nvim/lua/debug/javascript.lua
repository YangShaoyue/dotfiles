local M = {}

function M.config()
  require("dap-vscode-js").setup({
    -- vim.pack stores plugins in site/pack/core/opt/
    debugger_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/vscode-js-debug",
    adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' },
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
        protocol = "inspector"
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
        processId = require('dap.utils').pick_process,
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
end

return M
