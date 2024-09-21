require("config.options")
require("config.lazy")

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("config.utils")
		require("config.keymaps")
		require("config.highlight_groups")
		require("config.autocmd")
	end,
})

vim.keymap.set("n", "<Tab>n", function()
  print("woof")
end, {})
-- vim.keymap.set("n", "<Tab><leader>", function()
--   print("pin")
-- end, {})

vim.keymap.set("n", "<leader><Tab>", function()
  print("pong test")
end, {})
