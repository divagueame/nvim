vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.md" },
	callback = function()
		vim.fn.system("prettier --write " .. vim.fn.expand("%"))
		vim.cmd("edit")
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype ~= "markdown" then
			vim.lsp.buf.format()
		end
	end,
})
