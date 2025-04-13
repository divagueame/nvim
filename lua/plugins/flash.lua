return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	eys = {
		{
			"e",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
	},
}
