-- 	{
-- 		"sainnhe/gruvbox-material",
-- 		lazy = false,
-- 		priority = 1000,
-- 		config = function()
-- 			vim.g.gruvbox_material_background = "hard"
-- 			vim.g.gruvbox_material_enable_italic = tru
--
-- 			vim.cmd.colorscheme("gruvbox-material")
-- 			-- vim.api.nvim_set_hl(0, "Normal", { bg = "#0d0d0d" })
--
-- 			local function toggle_background()
-- 				if vim.o.background == "light" then
-- 					vim.o.background = "dark"
-- 				else
-- 					vim.o.background = "light"
-- 				end
-- 			end
--
-- 			vim.keymap.set("n", "<leader>ab", toggle_background, { desc = "Toggle Dark/Light mode" })
-- 		end,
-- 	},
-- {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function()
-- 		local colorschemes = { "gruvbox-material", "catppuccin-latte" }
-- 		local current_index = 1
-- 		-- vim.cmd.colorscheme("catppuccin")
--
-- 		local function rotate_colorschemes()
-- 			current_index = current_index % #colorschemes + 1
-- 			vim.cmd.colorscheme(colorschemes[current_index])
-- 		end
--
-- 		vim.keymap.set("n", "<leader>aa", rotate_colorschemes, { desc = "Rotate Colorschemes" })
--
-- 		-- vim.cmd.colorscheme("catppuccin-latte")
-- 	end,
-- },
-- }
return {
	"rebelot/kanagawa.nvim",
	config = function()
		require("kanagawa").setup({
			-- compile=true,
			transparent = true,
			overrides = function(colors)
				return {
					["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
					["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
					["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
					["@markup.raw.markdown_inline"] = { link = "String" }, -- `code`
					["@markup.list.markdown"] = { link = "Function" }, -- + list
					["@markup.quote.markdown"] = { link = "Error" }, -- > blockcode
					["@markup.list.checked.markdown"] = { link = "WarningMsg" }, -- - [X] checked list item
				}
			end,
		})
		vim.cmd("colorscheme kanagawa")

		vim.api.nvim_set_hl(0, "Visual", { bg = "#232323" }) -- Replace "#ff79c6" with a brighter background color
	end,
	build = function()
		vim.cmd("KanagawaCompile")
	end,
}
-- return {
-- 	"ramojus/mellifluous.nvim",
-- 	-- version = "v0.*", -- uncomment for stable config (some features might be missed if/when v1 comes out)
-- 	config = function()
-- 		require("mellifluous").setup({}) -- optional, see configuration section.
-- 		vim.cmd("colorscheme mellifluous")
-- 		vim.o.background = "light" -- For light theme, set vim.opt.background to "light". This will only work on colorsets that have light theme.
-- 	end,
-- }
