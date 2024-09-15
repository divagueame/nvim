return {
	-- "divagueame/aws-sam.nvim",
	dir = "/home/ma/web/plugins/aws-sam.nvim",
	dependencies = {
		"rcarriga/nvim-notify",
	},
	dev = true,
	config = function()
		require("aws-sam").setup({
			keymaps = true,
		})
	end,
}
