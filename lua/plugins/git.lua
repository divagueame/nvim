return {
	"lewis6991/gitsigns.nvim",
	opts = {
		-- See `:help gitsigns.txt`
		signs = {
			add = { text = "+" },
			change = { text = "|" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},

		on_attach = function(bufnr)
			local function next_hunk_or_buffer()
				local gs = require("gitsigns")
				if not gs.next_hunk() then
					vim.cmd("bnext")
					gs.next_hunk()
				end
			end

			-- vim.keymap.set("n", "<leader>sH, function()
			-- 	vim.cmd("DiffviewFileHistory")
			-- end, { desc = "View File History"})

			vim.keymap.set("n", "<leader>sJ", function()
				next_hunk_or_buffer()
			end, { desc = "Next Hunk or Buffer" })

			vim.keymap.set("n", "<leader>sj", function()
				require("gitsigns").nav_hunk("next")
			end, { desc = "Next Hunk" })

			vim.keymap.set("n", "<leader>sh", function()
				require("gitsigns").nav_hunk("prev")
			end, { desc = "Previous Hunk" })

			vim.keymap.set("n", "<leader>sk", function()
				require("gitsigns").stage_hunk()

				require("gitsigns").nav_hunk("next")
			end, { desc = "Stage hunk" })

			vim.keymap.set("n", "<leader>su", function()
				require("gitsigns").undo_stage_hunk()
			end, { desc = "Unstage hunk" })

			vim.keymap.set("n", "<leader>si", function()
				require("gitsigns").stage_buffer()
			end, { desc = "Stage buffer" })

			vim.keymap.set("n", "<leader>sl", function()
				require("gitsigns").preview_hunk()
			end, { desc = "Preview buffer" })

			vim.keymap.set("n", "<leader>sb", function()
				require("gitsigns").toggle_current_line_blame()
			end, { desc = "Toggle line blame" })

			vim.keymap.set("n", "<leader>sc", function()
				require("gitsigns").preview_hunk_inline()
			end, { desc = "Preview hunk inline" })

			vim.keymap.set("n", "<leader>sC", function()
				require("gitsigns").preview_hunk()
			end, { desc = "Preview hunk with hover" })
		end,
	},
}
