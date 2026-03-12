return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		-- "rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		-- build debugger from source
		{
			"microsoft/vscode-js-debug",
			version = "1.x",
			build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
		},
	},
	keys = {
		-- {
		-- 	"<leader>du",
		-- 	function()
		-- 		print("--- to")
		-- 		require("dapui").toggle()
		-- 	end,
		-- },
		{
			"<leader>dh",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle breakpoint",
		},
		{
			"<leader>dy",
			function()
				require("dap").run_to_cursor()
			end,

			desc = "Run to cursor",
		},
		{
			"<leader>d<leader>",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<leader>dj",
			function()
				require("dap").step_over()
			end,
			desc = "Step over",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step into",
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
			desc = "Step out",
		},
		{
			"<leader>dp",
			function()
				require("dap").pause()
			end,
			desc = "Pause",
		},
		{
			"<leader>d<tab>",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
		{
			"<leader>dl",
			function()
				require("dap").restart()
			end,
			desc = "Restart",
		},
		{
			"<leader>dm",
			function()
				require("dap").up()
			end,
			desc = "Move up the stack",
		},
		{
			"<leader>d,",
			function()
				require("dap").down()
			end,
			desc = "Move down the stack",
		},
		-- {
		-- 	"<leader>d;",
		-- 	function()
		-- 		require("dap").repl.open()
		-- 		-- require("dap").repl.toggle(nil, "tab split")
		-- 	end,
		-- 	desc = "Toggle DAP REPL",
		-- },
		-- {
		-- 	"<leader>do",
		-- 	function()
		-- 		local widgets = require("dap.ui.widgets")
		-- 		widgets.centered_float(widgets.frames)
		-- 	end,
		-- 	desc = "DAP Scopes",
		-- },
		-- {
		-- 	"<leader>ds",
		-- 	function()
		-- 		local widgets = require("dap.ui.widgets")
		-- 		widgets.centered_float(widgets.scopes, { border = "rounded" })
		-- 	end,
		-- 	desc = "DAP Scopes",
		-- },
	},

	config = function(_, opts)
		local dap = require("dap")
		-- local dap, dapui = require("dap"), require("dapui")
		--- Gets a path to a package in the Mason registry.
		--- Prefer this to `get_package`, since the package might not always be
		--- available yet and trigger errors.
		---@param pkg string
		---@param path? string
		local function get_pkg_path(pkg, path)
			pcall(require, "mason")
			local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
			path = path or ""
			local ret = root .. "/packages/" .. pkg .. "/" .. path
			return ret
		end

		-- PWA - Node
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = {
					get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
					"${port}",
				},
			},
		}

		local js_based_languages = {
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
			"vue",
		}

		for _, language in ipairs(js_based_languages) do
			dap.configurations[language] = {
				-- Debug single nodejs files
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
				},
				-- Debug nodejs processes (make sure to add --inspect when you run the process)
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
				},
				-- Debug web applications (client side)
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch & Debug Chrome",
					url = function()
						local co = coroutine.running()
						return coroutine.create(function()
							vim.ui.input({
								prompt = "Enter URL: ",
								default = "http://localhost:3000",
							}, function(url)
								if url == nil or url == "" then
									return
								else
									coroutine.resume(co, url)
								end
							end)
						end)
					end,
					webRoot = vim.fn.getcwd(),
					protocol = "inspector",
					sourceMaps = true,
					userDataDir = false,
				},
				-- Divider for the launch.json derived configs
				{
					name = "----- ↓ launch.json configs ↓ -----",
					type = "",
					request = "launch",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach to Alokai Middleware",
					port = 9229,
					cwd = "${workspaceFolder}/../shop-middleware/apps/storefront-middleware",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
					resolveSourceMapLocations = {
						"${workspaceFolder}/**",
						"!**/node_modules/**",
					},
				},
			}
		end
		-- Setup Virtual Text
		require("nvim-dap-virtual-text").setup({
			comment = true,
			virt_text_pos = "eol",
		})

		vim.fn.sign_define("DapBreakpoint", {
			text = "🔴",
			texthl = "DapBreakpoint",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapBreakpointCondition", {
			text = "🟡",
			texthl = "DapBreakpointCondition",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapBreakpointRejected", {
			text = "⭕",
			texthl = "DapBreakpointRejected",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapStopped", {
			text = "->",
			texthl = "DiagnosticHint",
			numhl = "",
		})

		local widgets = require("dap.ui.widgets")

		-- set scopes as right pane
		local scopes = widgets.sidebar(widgets.scopes, {}, "vsplit")
		-- set frames as bottom pane
		local frames = widgets.sidebar(widgets.frames, { height = 10 }, "belowright split")
		local repl = require("dap.repl")

		vim.keymap.set("n", "<leader>d/", function()
			return repl.toggle({}, "belowright split")
		end)

		vim.keymap.set("n", "<leader>ds", scopes.toggle)
		vim.keymap.set("n", "<leader>df", frames.toggle)
		vim.keymap.set("n", "<leader>dn", widgets.hover)

		-- Auto-open on breakpoint hit
		dap.listeners.after.event_initialized["dap_sidebar"] = function()
			scopes.open()
			frames.open()
		end
		dap.listeners.before.event_terminated["dap_sidebar"] = function()
			scopes.close()
			frames.close()
		end
		dap.listeners.before.event_exited["dap_sidebar"] = function()
			scopes.close()
			frames.close()
		end

		-- Setup Dap UI
		-- dapui.setup()
		-- require("dapui").setup({
		-- 	layouts = {
		-- 		{
		-- 			elements = {
		-- 				{ id = "scopes", size = 1.0 }, -- 100% of the layout
		-- 			},
		-- 			size = 16, -- Height of the bottom window in lines
		-- 			position = "bottom", -- Can be "top", "left", "right", or "bottom"
		-- 		},
		-- 	},
		-- })
		-- dapui.setup({
		-- 	layouts = {
		-- 		elements = {
		-- 			{ id = "scopes", size = 1.0 }, -- 100% of the layout
		-- 		},
		-- 		size = 10, -- Height of the bottom window in lines
		-- 		position = "bottom", -- Can be "top", "left", "right", or "bottom"
		-- 	},
		-- })
		-- dap.listeners.after.event_initialized["dapui_config"] = function()
		-- 	dapui.open({ reset = true })
		-- end
		-- dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		-- dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- Go / Delve adapter
		dap.adapters.delve = {
			type = "server",
			port = "${port}",
			executable = {
				command = "dlv",
				args = { "dap", "-l", "127.0.0.1:${port}" },
			},
		}

		-- Add a SEPARATE adapter for headless/remote connection:
		dap.adapters.delve_headless = {
			type = "server",
			host = "127.0.0.1",
			port = 2345,
			-- no executable! just connect to the already-running dlv
		}

		dap.configurations.go = {
			{
				type = "delve",
				name = "Debug",
				request = "launch",
				program = "${file}",
			},
			{
				type = "delve",
				name = "Debug GO",
				request = "launch",
				program = "${fileDirname}",
			},
			{
				type = "delve",
				name = "Attach",
				request = "attach",
				processId = require("dap.utils").pick_process,
			},
			{
				type = "delve_headless",
				name = "Attach headless (BubbleTea)",
				request = "attach",
				mode = "remote",
			},
		}
	end,
}
