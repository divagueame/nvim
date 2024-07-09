-- HighlightCurrentWord
function HighlightCurrentWord()
	local cursor_word = vim.fn.expand("<cword>")
	vim.cmd("match Search /" .. cursor_word .. "/")

	vim.defer_fn(function()
		vim.cmd("match NONE")
	end, 1500)
end

vim.api.nvim_set_keymap("n", "<Leader>h", ":lua HighlightCurrentWord()<CR>", { noremap = true, silent = true })

return {}
