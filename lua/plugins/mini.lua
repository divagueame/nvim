return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.surround").setup()
		require("mini.files").setup({})
	end,
	keys = {
		-- {
		-- 	"mm",
		-- 	function()
		-- 		require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
		-- 	end,
		-- 	desc = "Open mini.files (Directory of Current File)",
		-- },
		-- {
		-- 	"m,",
		-- 	function()
		-- 		require("mini.files").open(vim.uv.cwd(), true)
		-- 	end,
		-- 	desc = "Open mini.files (cwd)",
		-- },
	},
}
