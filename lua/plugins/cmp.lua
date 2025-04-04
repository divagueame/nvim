-- return {}
local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
			"windwp/nvim-autopairs",
			{ "hrsh7th/cmp-nvim-lsp" },
		},
		config = function()
			local cmp = require("cmp")
			local ls = require("luasnip")

			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
			require("luasnip.loaders.from_vscode").lazy_load()

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},
				performance = {
					debounce = 0, -- default is 60ms
					throttle = 0, -- default is 30ms
				},

				snippet = {
					expand = function(args)
						ls.lsp_expand(args.body)
					end,
				},
				mapping = {
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-e>"] = cmp.mapping.abort(),

					-- Manually trigger completion
					["<C-Space>"] = cmp.mapping.complete(),

					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

					-- Scroll documentation
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					["<Tab>"] = vim.schedule_wrap(function(fallback)
						if cmp.visible() and has_words_before() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						else
							fallback()
						end
					end),
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						-- the rest of the comparators are pretty much the defaults
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.scopes,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				sources = cmp.config.sources({
					{ name = "copilot", priority = 1002 },
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "luasnip", priority = 550 },
					{ name = "buffer", priority = 500 },
					{ name = "path", priority = 250 },
				}),

				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = function(entry, item)
						-- Apply lspkind formatting
						local lspkind_format = require("lspkind").cmp_format({
							maxwidth = 50,
							ellipsis_char = "...",
						})
						lspkind_format(entry, item)

						require("tailwindcss-colorizer-cmp").formatter(entry, item)

						vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
						local menu_icon = {
							copilot = "🍆",
							nvim_lsp = "🍕",
							luasnip = "📥",
							buffer = "📎",
							path = " ",
						}
						item.menu = menu_icon[entry.source.name]

						return item
					end,
				},
			})
		end,
	},
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},
}
