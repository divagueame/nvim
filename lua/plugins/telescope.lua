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
			{
				"<Leader><leader>f",
				"<cmd>Telescope find_files hidden=true<CR>",
				desc = "Find files (including hidden)",
			},
			{ "<Leader>g", "<cmd>Telescope live_grep<CR>", desc = "Grep files" },
			-- { "<Leader><leader>g", "<cmd>Telescope live_grep hidden=true<CR>", desc = "Grep files" },

			{
				"<Leader>gd",
				function()
					require("telescope.builtin").git_branches({
						attach_mappings = function(_, map)
							map("i", "<CR>", function(prompt_bufnr)
								local action_state = require("telescope.actions.state")
								local actions = require("telescope.actions")
								local selection = action_state.get_selected_entry()
								actions.close(prompt_bufnr)
								local current_file = vim.fn.expand("%")  --
								print(selection.value) -- gets me the branch name: line 'main'
								-- require("diffview").open(selection.value .. ":" .. current_file)
							end)
							return true
						end,
					})
				end,
				desc = "Diff File in Different Branches",
			},
			-- Grep text in hidden nuxt folders
			{
				"<Leader>F",
				function()
					require("telescope.builtin").live_grep({
						vimgrep_arguments = {
							"rg",
							"--color=never",
							"--no-heading",
							"--with-filename",
							"--line-number",
							"--column",
							"--smart-case",
							"--hidden", -- Include hidden files
							"--no-ignore",
							"--glob=!.nuxt/analyze/**",
							"--glob=!.git/**",
							"--glob=!**lock**",
							"--glob=!node_modules",
						},

						layout_strategy = "vertical",
						layout_config = {
							width = 0.9,
							height = 0.9,

							preview_cutoff = 0, -- Always show preview
							prompt_position = "top",
						},
					})
				end,
				desc = "Grep files (Hidden Included)",
			},
			{
				"<Leader><leader>g",
				function()
					require("telescope.builtin").live_grep({
						vimgrep_arguments = {
							"rg",
							"--color=never",
							"--no-heading",
							"--with-filename",
							"--line-number",
							"--column",
							"--smart-case",
							"--hidden", -- Include hidden files
							"--no-ignore",
							"--glob",
							"!.git/*", -- Exclude .git directory
							-- "!node_modules/*", -- Exclude node_modules
							-- ".nuxt/*", -- Explicitly include .nuxt
							-- ".output/*",
						},
					})
				end,
				desc = "Grep files (Hidden Included)",
			},
			{ "<Leader>h", "<cmd>Telescope quickfix<CR>", desc = "Quickfix" },
			{
				"<Leader><leader>gg",
				"<cmd>lua require('telescope.builtin').live_grep({ additional_args = function() return { '--case-sensitive' } end })<CR>",
				desc = "Grep Case Sensitive",
			},
			opts = function(_, opts) end,
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
					layout_config = {
						width = 290,
						vertical = {
							prompt_position = "top",
						},
					},
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
					fzf = {},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
