-- local function start_ruby_debugger()
--   local dap = require("dap")
--   vim.fn.setenv("RUBYOPT", "-rdebug/open")
--   dap.continue()
-- end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "suketa/nvim-dap-ruby",
    "mxsdev/nvim-dap-vscode-js",
    "leoluz/nvim-dap-go",
    -- lazy spec to build "microsoft/vscode-js-debug" from source
    {
      "microsoft/vscode-js-debug",
      -- version = "1.*",
      -- build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      -- build = "npm i --legacy-peer-deps && npm run compile vsDebugServerBundle && mv dist out",
    },
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    require("dap-go").setup()
    -- require("dap-ruby").setup()
    -- require("dap-go").setup()
    -- dap.set_log_level("TRACE")

    require("dap-vscode-js").setup({
      debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
      -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
      -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
      -- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
      adapters = {
        "chrome",
        "pwa-node",
        "pwa-chrome",
        "pwa-msedge",
        "node-terminal",
        "pwa-extensionHost",
        "node",
        "chrome",
      }, -- which adapters to register in nvim-dap
      -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
      -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
      -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
    })

    local js_based_languages = { "typescript", "javascript", "typescriptreact" }

    for _, language in ipairs(js_based_languages) do
      require("dap").configurations[language] = {
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
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = 'Start Chrome with "localhost"',
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
        },
      }
    end

    dap.adapters.ruby = function(callback, config)
      callback({
        type = "server",
        host = "127.0.0.1",
        port = "38698",
        executable = {
          command = "bundle",
          args = {
            "exec",
            "rdbg",
            "-n",
            "--open",
            "--port",
            "38698",
            "-c",
            "--",
            "bundle",
            "exec",
            config.command,
            config.script,
          },
        },
      })
    end

    dap.configurations.ruby = {
      {
        type = "ruby",
        name = "debug current file",
        request = "attach",
        localfs = true,
        command = "ruby",
        script = "${file}",
      },
      {
        type = "ruby",
        name = "run current spec file",
        request = "attach",
        localfs = true,
        command = "rspec",
        script = "${file}",
      },
    }

    -- Set custom signs for DAP
    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    vim.fn.sign_define(
      "DapBreakpointCondition",
      { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
    )
    vim.fn.sign_define(
      "DapBreakpointRejected",
      { text = "●", texthl = "DapBreakpointRejected", linehl = "", numhl = "" }
    )
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "", numhl = "" })

    -- Highlight groups
    vim.cmd("highlight DapBreakpoint guifg=#882230 guibg=NONE gui=bold")
    vim.cmd("highlight DapBreakpointCondition guifg=#882230 guibg=NONE gui=bold")
    vim.cmd("highlight DapBreakpointRejected guifg=#FF0000 guibg=NONE gui=bold")
    vim.cmd("highlight DapStopped guifg=#44dd99 guibg=NONE gui=bold")

    dapui.setup({})
    -- dapui.setup({
    --   layouts = {
    --     {
    --       elements = {
    --         {
    --           id = "scopes",
    --           size = 0.50,
    --         },
    --         -- {
    --         --   id = "breakpoints",
    --         --   size = 0.25,
    --         -- },
    --         {
    --           id = "stacks",
    --           size = 0.50,
    --         },
    --         -- {
    --         --   id = "watches",
    --         --   size = 0.25,
    --         -- },
    --       },
    --       position = "left",
    --       size = 42,
    --     },
    --     {
    --       elements = {
    --         {
    --           id = "repl",
    --           size = 1,
    --         },
    --         -- {
    --         --   id = "console",
    --         --   size = 0.5,
    --         -- },
    --       },
    --       position = "bottom",
    --       size = 10,
    --     },
    --   },
    -- })

    dap.listeners.before.attach.dapui_config = function()
      dapui.open({})
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open({})
    end

    dap.listeners.after.event_initialized.dapui_config = function()
      dapui.open({})
      vim.cmd("colorscheme " .. vim.g.colors_name)
    end

    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
      vim.defer_fn(function()
        dapui.open()
        dap.restart()
      end, 100)
    end

    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close({})
    end

    vim.keymap.set("n", "<leader>dd", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<leader>ui", require("dapui").toggle)

    vim.api.nvim_set_keymap(
      "n",
      "<leader>dv",
      "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('[Condition] > '))<CR>",
      { noremap = true, silent = true, desc = "Set Conditional Breakpoint" }
    )
    -- vim.keymap.set("n", "<leader>d0", function()
    --   local filetype = vim.bo.filetype
    --   if filetype == "ruby" then
    --     start_ruby_debugger()
    --   else
    --     require("dap").continue()
    --   end
    -- end, { desc = "Start debugging" })

    -- }
    -- vim.keymap.set('n', '<F5>', require 'dap'.continue)
    -- vim.keymap.set('n', '<F10>', require 'dap'.step_over)
    -- vim.keymap.set('n', '<F11>', require 'dap'.step_into)
    -- vim.keymap.set('n', '<F12>', require 'dap'.step_out)
    -- vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)
    -- vim.keymap.set('n', '<leader>B', function()
    --   require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    -- end)
    vim.keymap.set("n", "<leader>df", dap.continue, { desc = "Continue debugging" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
    vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart" })

    vim.keymap.set("n", "<leader>dw", function()
      require("dap.ui.widgets").hover()
    end, { desc = "Widget hover" })

    vim.keymap.set("n", "<leader>de", dap.terminate, { desc = "End debug session" })
  end,
}
