return {
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_enable_italic = true
			vim.cmd.colorscheme("gruvbox-material")
			-- vim.api.nvim_set_hl(0, "Normal", { bg = "#0d0d0d" })

			local function toggle_background()
				if vim.o.background == "light" then
					vim.o.background = "dark"
				else
					vim.o.background = "light"
				end
			end

			vim.keymap.set("n", "<leader>ab", toggle_background, { desc = "Toggle Dark/Light mode" })
		end,
	},
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
}
