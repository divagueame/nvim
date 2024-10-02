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
		end,
	},
}
