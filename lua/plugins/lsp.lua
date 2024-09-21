return {
	'neovim/nvim-lspconfig',
	--cmd = { 'LspInfo', 'LspLog', 'LspRestart', 'LspStart', 'LspStop' },

	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/nvim-cmp',
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		'j-hui/fidget.nvim',
	},

	config = function()
        local cmp = require('cmp')
        local cmp_lsp = require('cmp_nvim_lsp')
        local capabilities = vim.tbl_deep_extend(
            'force',
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require('fidget').setup({})
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                'lua_ls',
                'tailwindcss',
                'volar',
                'ts_ls',
                'rust_analyzer',
                -- 'gopls',
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                ['ts_ls'] = function ()
                    local mason_registry = require('mason-registry')
                    local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'

                    local lspconfig = require('lspconfig')

                    lspconfig.ts_ls.setup {
                        init_options = {
                            plugins = {
                                {
                                    name = '@vue/typescript-plugin',
                                    location = vue_language_server_path,
                                    languages = { 'vue' },
                                },
                            },
                        },
                        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
                    }
                end,
                ['lua_ls'] = function()
                    local lspconfig = require('lspconfig')
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = 'Lua 5.1' },
                                diagnostics = {
                                    globals = { 'bit', 'vim', 'it', 'describe', 'before_each', 'after_each' },
                                }
                            }
                        }
                    }
                end,
                ['gopls'] = function ()
                    local lspconfig = require('lspconfig')
                    lspconfig.gopls.setup{}
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                    { name = 'buffer' },
                })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = 'minimal',
                border = 'rounded',
                source = 'always',
                header = '',
                prefix = '',
            },
        })

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
        vim.keymap.set(
          "n",
          "<space>ji",
          vim.lsp.buf.rename,
          vim.tbl_extend("force", opts, { desc = "LSP - Rename Reference" })
        )
    end
}
--
--
--
-- return {
-- 	"williamboman/mason.nvim",
-- 	dependencies = {
-- 		"williamboman/mason-lspconfig.nvim",
-- 		"neovim/nvim-lspconfig",
-- 		"folke/neoconf.nvim",
-- 		"folke/neodev.nvim",
-- 		"hrsh7th/cmp-nvim-lsp",
-- 	},
-- 	config = function()
-- 		require("neoconf").setup({})
-- 		require("neodev").setup({})
-- 		require("mason").setup()
-- local default_servers = {
--      'volar',
-- }
--
-- require('mason-lspconfig').setup_handlers({
-- 	function(server_name)
--                  local server_config = nil
-- 		if server_name == 'volar' then 
-- 			{filetypes = { 'vue', 'typescript', 'javascript' }}
-- 		end
-- 		lspconfig[server_name].setup(
-- 			server_config
-- 		)
-- 	end,
-- })
-- 		-- local server_settings = require("plugins.lsp.servers")
-- 		--
-- 		-- require("mason-lspconfig").setup({
-- 		-- 	ensure_installed = server_settings.default_servers,
-- 		-- })
-- 		-- local lspconfig = require("lspconfig")
-- 		--
-- 		-- server_settings.setup()
-- 		--
-- 		-- require("mason-lspconfig").setup_handlers({
-- 		-- 	function(server_name)
-- 		-- 		if server_settings.is_disabled(server_name) then
-- 		-- 			return
-- 		-- 		end
-- 		-- 		lspconfig[server_name].setup(server_settings.get_config(server_name))
-- 		-- 	end,
-- 		-- })
-- 		--
-- 		-- -- setup diagnostics
-- 		-- require("plugins.lsp.diagnostics").setup()
-- 	end,
-- }
--
-- -- return {
-- --   -- Mason
-- --   {
-- --     "williamboman/mason.nvim",
-- --     config = function()
-- --       require("mason").setup()
-- --     end,
-- --   },
-- --   {
-- --     "williamboman/mason-lspconfig.nvim",
-- --     config = function()
-- --       require("mason-lspconfig").setup({
-- --         automatic_installation = true,
-- --         ensure_installed = {
-- --           "pyright",
-- --           "volar",
-- --           -- "ts_ls"
-- --
-- --           -- "typescript-language-server"
-- --           -- "lua_ls",
-- --           -- "rust_analyzer",
-- --           -- "ruby_lsp",
-- --           -- "tsserver",
-- --           -- "solargraph",
-- --           -- "gopls",
-- --           -- "phpactor",
-- --           -- "tailwindcss",
-- --         },
-- --         handlers = {
-- --           function(server)
-- --             local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
-- --             local lspconfig = require('lspconfig')
-- --             lspconfig[server].setup({
-- --               capabilities = lsp_capabilities,
-- --             })
-- --           end,
-- --           -- ['tsserver'] = function()
-- --           --   local lspconfig = require('lspconfig')
-- --           --   lspconfig.tsserver.setup({
-- --           --     capabilities = require('cmp_nvim_lsp').default_capabilities(),
-- --           --     settings = {
-- --           --       completions = {
-- --           --         completeFunctionCalls = true
-- --           --       }
-- --           --     }
-- --           --   })
-- --           -- end
-- --         },
-- --
-- --       })
-- --     end,
-- --   },
-- --   {
-- --     "pmizio/typescript-tools.nvim",
-- --     dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
-- --     opts = {},
-- --   },
-- --   -- LSP Configuration
-- --   {
-- --     "neovim/nvim-lspconfig",
-- --     dependencies = {
-- --       "hrsh7th/cmp-nvim-lsp",
-- --       -- "pmizio/typescript-tools.nvim",
-- --     },
-- --     config = function()
-- --       local lspconfig_status, lspconfig = pcall(require, "lspconfig")
-- --       if not lspconfig_status then
-- --         return
-- --       end
-- --
-- --       local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- --       if not cmp_nvim_lsp_status then
-- --         return
-- --       end
-- --
-- --       -- Capabilities
-- --       local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- --       capabilities.textDocument.foldingRange = {
-- --         dynamicRegistration = false,
-- --         lineFoldingOnly = true,
-- --       }
-- --
-- --       -- On attach function
-- --       local on_attach = function(_client, bufnr)
-- --         local opts = { noremap = true, silent = true, buffer = bufnr }
-- --         vim.keymap.set(
-- --           "n",
-- --           "<leader>jk",
-- --           vim.lsp.buf.hover,
-- --           vim.tbl_extend("force", opts, { desc = "LSP - Hover info" })
-- --         )
-- --         vim.keymap.set(
-- --           "n",
-- --           "<leader>jj",
-- --           vim.lsp.buf.definition,
-- --           vim.tbl_extend("force", opts, { desc = "LSP - Definition" })
-- --         )
-- --         vim.keymap.set(
-- --           "n",
-- --           "<leader>jl",
-- --           "<cmd>Telescope lsp_references<cr>",
-- --           vim.tbl_extend("force", opts, { desc = "LSP - References (Telescope)" })
-- --         )
-- --         vim.keymap.set(
-- --           "n",
-- --           "<leader>j<CR>",
-- --           vim.lsp.buf.code_action,
-- --           vim.tbl_extend("force", opts, { desc = "LSP - Code action" })
-- --         )
-- --         vim.keymap.set(
-- --           "n",
-- --           "<space>ji",
-- --           vim.lsp.buf.rename,
-- --           vim.tbl_extend("force", opts, { desc = "LSP - Rename Reference" })
-- --         )
-- --       end
-- --
-- --       local servers = {
-- --         "lua_ls",
-- --         "rust_analyzer",
-- --         "ruby_lsp",
-- --         "solargraph",
-- --         "gopls",
-- --         "phpactor",
-- --         "tailwindcss",
-- --         "ts_ls",
-- --         "pyright"
-- --       }
-- --
-- --       for _, server in ipairs(servers) do
-- --         lspconfig[server].setup({
-- --           capabilities = capabilities,
-- --           on_attach = on_attach,
-- --         })
-- --       end
-- --
-- --       -- Special configurations
-- --       lspconfig.stimulus_ls.setup({
-- --         cmd = { "node", "/home/ma/web/source/stimulus-lsp/server/out/server.js", "--stdio" },
-- --         capabilities = capabilities,
-- --         on_attach = on_attach,
-- --       })
-- --
-- --       -- TypeScript setup
-- --       require("typescript-tools").setup({
-- --         capabilities = capabilities,
-- --         on_attach = on_attach,
-- --       })
-- --     end,
-- --   },
-- -- }
