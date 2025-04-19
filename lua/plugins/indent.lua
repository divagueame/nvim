return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}

		local hooks = require("ibl.hooks")
		-- create the highlight groups in the highlight setup hook, so they are reset
		-- every time the colorscheme changes
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#a56c7b" }) -- soft mauve
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#b38d8b" }) -- sakura-tinted beige
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#7e9cd8" }) -- kanagawa blue
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#c49a6c" }) -- lotus root
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#a9b665" }) -- subtle green
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#957fb8" }) -- misty violet
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#7fb4ca" }) -- cool and soft -- chill cyan
		end)

		require("ibl").setup({ indent = { highlight = highlight, char = "▏" } })
	end,
}
