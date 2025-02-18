-- return {}
return {
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>hh", "<cmd>DiffviewOpen<cr>" },
			{ "<leader>cc", "<cmd>set hidden<cr><cmd>DiffviewClose<cr><cmd>set nohidden<cr>" },
		},
		opts = {
			view = {
				-- Configure the layout and behavior of different types of views.
				-- Available layouts:
				--  'diff1_plain'
				--    |'diff2_horizontal'
				--    |'diff2_vertical'
				--    |'diff3_horizontal'
				--    |'diff3_vertical'
				--    |'diff3_mixed'
				--    |'diff4_mixed'
				-- For more info, see |diffview-config-view.x.layout|.
				default = {
					-- Config for changed files, and staged files in diff views.
					layout = "diff2_horizontal",
					disable_diagnostics = false, -- Temporarily disable diagnostics for diff buffers while in the view.
					winbar_info = false, -- See |diffview-config-view.x.winbar_info|
				},
				merge_tool = {
					-- Config for conflicted files in diff views during a merge or rebase.
					layout = "diff3_vertical",
					-- layout = "diff3_horizontal",
					-- layout = "diff3_horizontal",
					disable_diagnostics = true, -- Temporarily disable diagnostics for diff buffers while in the view.
					winbar_info = true, -- See |diffview-config-view.x.winbar_info|
				},
				file_history = {
					layout = "diff2_horizontal",
					disable_diagnostics = false, -- Temporarily disable diagnostics for diff buffers while in the view.
					winbar_info = false, -- See |diffview-config-view.x.winbar_info|
				},
			},
		},
	},
	-- {
	--   'akinsho/git-conflict.nvim',
	--   version = "*",
	--   config = function ()
	--     vim.api.nvim_set_hl(0, "IncomingDiffColor", { fg = "#C8BFC7", bg = "#1C2826" })
	--     vim.api.nvim_set_hl(0, "CurrentDiffColor", { fg = "#C8BFC7", bg = "#2A1F2D" })
	--     require('git-conflict').setup({
	--       default_mappings = true, -- disable buffer local mapping created by this plugin
	--       default_commands = true, -- disable commands created by this plugin
	--       disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
	--       list_opener = 'copen', -- command or function to open the conflicts list
	--       highlights = { -- They must have background color, otherwise the default color will be used
	--         incoming = 'IncomingDiffColor',
	--         current = 'CurrentDiffColor',
	--       }
	--     })
	--   end
	-- }
}
