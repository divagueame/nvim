return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"pylint",
				"eslint",
				"eslint_d",
				"stylua",
				"shfmt",
			},
		},
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"volar",
				"ts_ls",
				"yamlls",
				"rust_analyzer",
				"pyright",
				"html",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"emmet_ls",
				"gopls",
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"hrsh7th/cmp-nvim-lsp", -- Allows extra capabilities provided by nvim-cmp
		},
		config = function()
			-- LspAttach
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					vim.keymap.set("n", "<space><space>l", function()
						local command = "npx eslint . --fix"
						vim.fn.system(command)
						vim.cmd("silent! edit!")
					end, { desc = "Lint project" })
					vim.keymap.set("n", "<space>ll", function()
						local file = vim.fn.expand("%") -- Get the current file path
						print("Linting " .. file)
						local command = "npx eslint " .. file .. " --fix"
						vim.fn.system(command)
						vim.cmd("silent! edit!")
						print("Linting complete for " .. file)
					end, { desc = "Trigger linting for current file" })
					--  To jump back, press <C-t>.
					map("gd", require("telescope.builtin").lsp_definitions, "LSP Definition")
					map("gh", vim.lsp.buf.hover, "LSP Hover")
					map("gr", require("telescope.builtin").lsp_references, "LSP References")
					map("gI", require("telescope.builtin").lsp_implementations, "LSP - Implementation")
					map("gt", require("telescope.builtin").lsp_type_definitions, "LSP - Type Definition")
					map("gds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map("gws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
					map("gR", vim.lsp.buf.rename, "LSP Rename")
					map("ga", vim.lsp.buf.code_action, "LSP - Action", { "n", "x" })
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("gdw", vim.diagnostic.open_float, "diagnostic on a window")

					map("gF", function()
						vim.lsp.buf.format({ async = true })
						vim.cmd("write")
					end, "LSP - Format")


					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			--- Capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local border = {
				{ "┌", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "┐", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "┘", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "└", "FloatBorder" },
				{ "│", "FloatBorder" },
			}

			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
					border = border,

					width = 800,
				}),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
					border = border,
					width = 80,
				}),
			}
			local mason_registry = require("mason-registry")
			local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
				.. "/node_modules/@vue/language-server"

			local servers = {
				gopls = {},
				ts_ls = {
					handlers = handlers,
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								location = vue_language_server_path,
								languages = { "vue" },
							},
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = { disable = { "missing-fields" } },
						},
					},
				},
				ruby_lsp = {
					init_options = {
						formatter = "standard",
						linters = { "standard" },
					},
				},
			}

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritepre",
		opts = {
			notify_on_error = true,
			formatters = {},
			formatters_by_ft = {
				sh = { "beautysh" },
				bash = { "beautysh" },
				zsh = { "beautysh" },
				lua = { "stylua" },
				json = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				python = { "ruff", "black" },
				markdown = { "prettier" },
				sql = { "sqlfmt" },
			},
			format_on_save = { timeout_ms = 2000 },
		},
	},
}
