return {
	-- Mason
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"ruby_lsp",
					-- "tsserver",
					"solargraph",
					"gopls",
					"phpactor",
					"tailwindcss",
				},
			})
		end,
	},

	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"pmizio/typescript-tools.nvim",
		},
		config = function()
			local lspconfig_status, lspconfig = pcall(require, "lspconfig")
			if not lspconfig_status then
				return
			end

			local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if not cmp_nvim_lsp_status then
				return
			end

			-- Capabilities
			local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			-- On attach function
			local on_attach = function(_client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set(
					"n",
					"<leader>jk",
					vim.lsp.buf.hover,
					vim.tbl_extend("force", opts, { desc = "LSP - Hover info" })
				)
				vim.keymap.set(
					"n",
					"<leader>jj",
					vim.lsp.buf.definition,
					vim.tbl_extend("force", opts, { desc = "LSP - Definition" })
				)
				vim.keymap.set(
					"n",
					"<leader>jl",
					"<cmd>Telescope lsp_references<cr>",
					vim.tbl_extend("force", opts, { desc = "LSP - References (Telescope)" })
				)
				vim.keymap.set(
					"n",
					"<leader>j<CR>",
					vim.lsp.buf.code_action,
					vim.tbl_extend("force", opts, { desc = "LSP - Code action" })
				)
			end

			local servers = {
				"lua_ls",
				"rust_analyzer",
				"ruby_lsp",
				"solargraph",
				"gopls",
				"phpactor",
				"tailwindcss",
			}

			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end

			-- Special configurations
			lspconfig.stimulus_ls.setup({
				cmd = { "node", "/home/ma/web/source/stimulus-lsp/server/out/server.js", "--stdio" },
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- TypeScript setup
			require("typescript-tools").setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	},
}
