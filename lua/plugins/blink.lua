-- return {
-- 	"saghen/blink.cmp",
--     event = "InsertEnter",
-- 	dependencies = "rafamadriz/friendly-snippets",
--     enabled = true,
-- 	version = "*",
-- 	---@module 'blink.cmp'
-- 	---@type blink.cmp.Config
-- 	opts = {
-- 		completion = {
-- 			accept = { auto_brackets = { enabled = true } },
-- 			ghost_text = { enabled = true },
-- 			menu = {
-- 				scrolloff = 1,
-- 				scrollbar = false,
-- 				auto_show = function(ctx)
-- 					return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
-- 				end,
-- 				draw = {
-- 					columns = { { "label" }, { "kind_icon" } },
-- 					treesitter = { "lsp" },
-- 				},
-- 				border = {
-- 					-- { "╭", "Comment" },
-- 					-- { "─", "WarningMsg" },
-- 					{ "󱐋", "WarningMsg" },
-- 					{ "─", "Comment" },
-- 					{ "╮", "Comment" },
-- 					{ "│", "Comment" },
-- 					{ "╯", "Comment" },
-- 					{ "─", "Comment" },
-- 					{ "╰", "Comment" },
-- 					{ "│", "Comment" },
-- 				},
-- 			},
-- 		},
-- 		keymap = {
-- 			preset = "none",
-- 			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
-- 			["<C-e>"] = { "hide", "fallback" },
-- 			["<CR>"] = { "accept", "fallback" },
--
-- 			["<Tab>"] = { "snippet_forward", "fallback" },
-- 			["<S-Tab>"] = { "snippet_backward", "fallback" },
--
-- 			["<C-k>"] = { "select_prev", "fallback" },
-- 			["<C-j>"] = { "select_next", "fallback" },
--
-- 			["<C-u>"] = { "scroll_documentation_up", "fallback" },
-- 			["<C-i>"] = { "scroll_documentation_down", "fallback" },
-- 		},
-- 		appearance = {
-- 			use_nvim_cmp_as_default = true,
-- 			nerd_font_variant = "mono",
-- 		},
-- 		sources = {
-- 			default = { "lsp", "path", "snippets", "buffer" },
-- 		},
-- 	},
-- 	opts_extend = { "sources.default" },
-- }
--

return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	enabled = true,
	build = "cargo build --release",
	-- lazy = false, -- lazy loading handled internally
	dependencies = "rafamadriz/friendly-snippets",

	opts = {

		-- signature = { window = { border = "single" } },
		completion = {
			-- --------------------------------------------------------------------------------------------
			-- important section --> https://cmp.saghen.dev/configuration/reference.html
			-- --------------------------------------------------------------------------------------------
			accept = { auto_brackets = { enabled = true } },
			ghost_text = { enabled = true },
			menu = {
				-- min_width = 15,
				-- max_height = 10,
				scrolloff = 1,
				scrollbar = false,

				border = {
					-- { "╭", "Comment" },
					-- { "─", "WarningMsg" },
					{ "󱐋", "WarningMsg" },
					{ "─", "Comment" },
					{ "╮", "Comment" },
					{ "│", "Comment" },
					{ "╯", "Comment" },
					{ "─", "Comment" },
					{ "╰", "Comment" },
					{ "│", "Comment" },
				},

				auto_show = function(ctx)
					return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
				end,

				-- draw = { columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } } },
				draw = {
					columns = { { "label" }, { "kind_icon" } },
					treesitter = { "lsp" },
				},
			},

			documentation = {
				auto_show = false,
				auto_show_delay_ms = 500,
				window = {
					border = {
						-- { "╭", "Comment" },
						{ "i", "DiagnosticHint" },
						{ "─", "Comment" },
						{ "╮", "Comment" },
						{ "│", "Comment" },
						{ "╯", "Comment" },
						{ "─", "Comment" },
						{ "╰", "Comment" },
						{ "│", "Comment" },
					},
					scrollbar = true,
				},
			},

			list = {
				-- Maximum number of items to display
				-- max_items = 200,

				selection = {
					-- When `true`, will automatically select the first item in the completion list
					preselect = false,
					-- preselect = function(ctx) return ctx.mode ~= "cmdline" end,

					-- weather or not insert the selected item (for preview purposes)
					auto_insert = true,
					-- auto_insert = function(ctx) return ctx.mode ~= 'cmdline' end
				},
			},

			keyword = {
				-- 'prefix' will fuzzy match on the text before the cursor
				-- 'full' will fuzzy match on the text before *and* after the cursor
				-- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
				range = "prefix",
			},
		},

		keymap = {
			-- set to 'none' to disable the 'default' preset
			preset = "none",

			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<CR>"] = { "accept", "fallback" },

			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },

			["<C-u>"] = { "scroll_documentation_down", "fallback" },
			["<C-i>"] = { "scroll_documentation_up", "fallback" },

			["<C-n>"] = { "snippet_forward", "fallback" },
			["<C-m>"] = { "snippet_backward", "fallback" },
			-- ["<Tab>"] = { "snippet_forward", "fallback" },
			-- ["<S-Tab>"] = { "snippet_backward", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",

			kind_icons = {
				Text = "󰉿",
				Method = "󰊕",
				Function = "󰊕",
				Constructor = "󰒓",

				Field = "󰜢",
				Variable = "󰆦",
				Property = "󰖷",

				Class = "󱡠",
				Interface = "󱡠",
				Struct = "󱡠",
				Module = "󰅩",

				Unit = "󰪚",
				Value = "󰦨",
				Enum = "󰦨",
				EnumMember = "󰦨",

				Keyword = "󰻾",
				Constant = "󰏿",

				Snippet = "󱄽",
				Color = "󰏘",
				File = "󰈔",
				Reference = "󰬲",
				Folder = "󰉋",
				Event = "󱐋",
				Operator = "󰪚",
				TypeParameter = "󰬛",
			},
		},
	},
}
