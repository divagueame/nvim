-- return {}
return {
	-- "divagueame/aws-sam.nvim",
	dir = os.getenv("HOME") .. "/web/plugins/lacasitos.nvim",
	event = "VeryLazy",
	dependencies = {
		-- {
		-- "rcarriga/nvim-notify",
		-- }
	},
	-- event = "BufReadPost",
	dev = true,
	config = function() end,
}
