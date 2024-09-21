return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
		},
		keys = {
			{ "<Leader>f", "<cmd>Telescope find_files<CR>", desc = "Find files" },
			{ "<Leader>g", "<cmd>Telescope live_grep<CR>", desc = "Grep files" },
			{ "<Leader>h", "<cmd>Telescope quickfix<CR>", desc = "Quickfix" },
		},

		-- config = function()
		-- local builtin = require("telescope.builtin")
		-- vim.keymap.set("n", "<Leader>f", function()
		-- 	builtin.find_files({ no_ignore = false })
		-- end, { desc = "Find files" })
		-- vim.keymap.set("n", "<Leader>g", function()
		-- 	builtin.live_grep({ no_ignore = true })
		-- end, { desc = "Grep files" })
		-- vim.api.nvim_set_keymap("n", "<leader>vm", "<cmd>Telescope quickfix<cr>", { noremap = true })
		-- end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			local file_ignore_patterns = {
				"yarn%.lock",
				"node_modules/",
				"raycast/",
				"dist/",
				"%.next",
				"%.git/",
				"%.gitlab/",
				"build/",
				"target/",
				"package%-lock%.json",
			}

			require("telescope").setup({
				file_ignore_patterns = file_ignore_patterns,
				defaults = {
					ripgrep_arguments = {
						"rg",
						"--hidden",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
				},

				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
