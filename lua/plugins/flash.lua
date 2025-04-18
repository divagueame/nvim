return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = { search = { enabled = true } },
		chars = { enabled = false },
	},
	keys = {
		{
			"E",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
	},
}
