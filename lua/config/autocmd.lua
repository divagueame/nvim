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
	local current_file_dir = vim.fn.expand("%:p:h")

	local test_file_pattern = current_file_dir .. "/*.nuxt.test.ts"
	local test_file = vim.fn.glob(test_file_pattern)

	local wezterm_command =
		string.format("wezterm start -- bash -c 'cd %s && yarn vitest %s; exec bash'", current_file_dir, test_file)

	os.execute(wezterm_command)
end
