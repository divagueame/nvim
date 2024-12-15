--- Highlight Yank
local yank_group = vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = "*",
	group = yank_group,
	callback = function()
		vim.highlight.on_yank({ higroup = "YankColor", timeout = 200 })
	end,
})

-- Autosave
vim.api.nvim_create_autocmd({
	"FocusLost",
	"BufLeave",
	-- "ModeChanged",
	-- "TextChanged",
	-- "BufEnter"
}, { desc = "autosave", pattern = "*", command = "silent! update" })

-- Toggle line wrapping
vim.api.nvim_set_keymap(
	"n",
	"<leader>lw",
	":set wrap!<CR>",
	{ noremap = true, silent = true, desc = "Toggle Line Wrap" }
)
vim.api.nvim_create_user_command("ToggleWrap", function()
	vim.wo.wrap = not vim.wo.wrap
	print("Line wrap is now " .. (vim.wo.wrap and "on" or "off"))
end, {})

-- Help full window
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		vim.cmd("only") -- Close all other splits
	end,
})
