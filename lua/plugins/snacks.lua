return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- dashboard = { enabled = true },
		-- input = { enabled = true },
		bigfile = { enabled = true },
		indent = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		quickfile = { enabled = true },
		-- scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		styles = {
			notification = {
				-- wo = { wrap = true } -- Wrap notifications
			},
		},
	},
	keys = {
		{
			"<leader>rf",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		-- {
		-- 	"<leader>S",
		-- 	function()
		-- 		Snacks.scratch.select()
		-- 	end,
		-- 	desc = "Select Scratch Buffer",
		-- },
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
		-- {
		-- 	"<Tab>u",
		-- 	function()
		-- 		vim.cmd("silent! write")
		-- 		Snacks.bufdelete()
		-- 	end,
		-- 	desc = "Delete Buffer",
		-- },
		-- {
		-- 	"<leader>gB",
		-- 	function()
		-- 		Snacks.gitbrowse()
		-- 	end,
		-- 	desc = "Git Browse",
		-- },
		-- {
		-- 	"<leader>gb",
		-- 	function()
		-- 		Snacks.git.blame_line()
		-- 	end,
		-- 	desc = "Git Blame Line",
		-- },
		-- {
		-- 	"<leader>gf",
		-- 	function()
		-- 		Snacks.lazygit.log_file()
		-- 	end,
		-- 	desc = "Lazygit Current File History",
		-- },
		-- {
		-- 	"<leader>gg",
		-- 	function()
		-- 		Snacks.lazygit()
		-- 	end,
		-- 	desc = "Lazygit",
		-- },
		-- {
		-- 	"<leader>gl",
		-- 	function()
		-- 		Snacks.lazygit.log()
		-- 	end,
		-- 	desc = "Lazygit Log (cwd)",
		-- },
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		-- {
		-- "<c-/>",
		-- 	function()
		-- 		Snacks.terminal()
		-- 	end,
		-- 	desc = "Toggle Terminal",
		-- },
		-- {
		-- 	"<c-_>",
		-- 	function()
		-- 		Snacks.terminal()
		-- 	end,
		-- 	desc = "which_key_ignore",
		-- },

		-- {
		-- 	"<F13>i",
		-- 	function()
		-- 		print("meoww")
		-- 	end,
		-- 	desc = "Next Reference",
		-- 	mode = { "n", "t" },
		-- },
		-- {
		-- 	"<C-o>",
		-- 	function()
		-- 		print("meow")
		-- 		-- Snacks.words.jump(vim.v.count1)
		-- 	end,
		-- 	desc = "Next Reference",
		-- 	mode = { "n", "t" },
		-- },
		-- {
		-- 	"<F13>u",
		-- 	function()
		-- 		Snacks.words.jump(-vim.v.count1)
		-- 	end,
		-- 	desc = "Prev Reference",
		-- 	mode = { "n", "t" },
		-- },
		-- {
		-- 	"<leader>N",
		-- 	desc = "Neovim News",
		-- 	function()
		-- 		Snacks.win({
		-- 			file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
		-- 			width = 0.6,
		-- 			height = 0.6,
		-- 			wo = {
		-- 				spell = false,
		-- 				wrap = false,
		-- 				signcolumn = "yes",
		-- 				statuscolumn = " ",
		-- 				conceallevel = 3,
		-- 			},
		-- 		})
		-- 	end,
		-- },
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				-- Snacks.toggle
				-- 	.option("background", { off = "light", on = "dark", name = "Dark Background" })
				-- 	:map("<leader>ub")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>ug")
			end,
		})
	end,
}
