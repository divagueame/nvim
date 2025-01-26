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

-- Help full window
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		vim.cmd("only") -- Close all other splits
	end,
})

vim.api.nvim_set_keymap("n", "<leader>tt", [[:lua RunTestFile()<CR>]], { noremap = true, silent = true })

function RunTestFile()
	local file = vim.fn.expand("%:t")
	local joviva_home = os.getenv("JOVIVA_HOME")

	local wezterm_command =
		string.format("wezterm start -- bash -c 'cd %s && yarn vitest %s; exec bash'", joviva_home, file)

	local i3_command = string.format("i3-msg 'workspace number 3; exec \"%s\"'", wezterm_command)

	-- Execute the i3-msg command
	os.execute(i3_command)
end
