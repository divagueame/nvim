require("config.options")
require("config.lazy")

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("config.colemak")
		require("config.utils")
		require("config.keymaps")
		require("config.highlight_groups")
		require("config.autocmd")
	end,
})
