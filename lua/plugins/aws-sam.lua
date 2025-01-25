-- return {}
return {
	{
		-- "divagueame/lacasitos.nvim",
		dir = os.getenv("HOME") .. "/web/plugins/lacasitos.nvim",
		-- event = "BufReadPost",
		dev = true,
		config = function()
			require("lacasitos").setup({})
			print("Loading lacasitos plugin...")
		end,
	},
	{
		-- "divagueame/aws-sam.nvim",
		dir = os.getenv("HOME") .. "/web/plugins/aws-sam.nvim",
		dependencies = {
			{
				"rcarriga/nvim-notify",
				"divagueame/lacasitos.nvim",
			},
		},
		-- event = "BufReadPost",
		dev = true,
		config = function()
			require("aws-sam").setup({
				-- keymaps = true,
				keymaps = false,
			})
		end,
	},
}
