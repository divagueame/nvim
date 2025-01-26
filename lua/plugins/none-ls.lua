return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier.with({
					filetypes = { "html", "json", "yaml", "markdown", "jsx", "tsx" },
				}),
				-- null_ls.builtins.diagnostics.eslint_d,
				-- null_ls.builtins.diagnostics.rubocop,
				-- null_ls.builtins.formatting.rubocop,
				-- null_ls.builtins.completion.luasnip,
			},
		})

		vim.keymap.set("n", "<leader>er", vim.lsp.buf.format, { desc = "LSP - Buf format" })
	end,
}
