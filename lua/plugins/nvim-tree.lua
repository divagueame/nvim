return {
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = {
			{
				"b0o/nvim-tree-preview.lua",
				dependencies = {
					"nvim-lua/plenary.nvim",
					"3rd/image.nvim", -- Optional, for previewing images
				},
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local nvimtree = require("nvim-tree")

			-- recommended settings from nvim-tree documentation
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			-- change color for arrows in tree to light blue
			--    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
			--    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

			-- configure nvim-tree
			nvimtree.setup({
				view = {
					width = 35,
					relativenumber = true,
				},
				-- change folder arrow icons
				renderer = {
					indent_markers = {
						enable = true,
					},
					icons = {
						glyphs = {
							folder = {
								--              arrow_closed = "", -- arrow when folder is closed
								--              arrow_open = "", -- arrow when folder is open
							},
						},
					},
				},
				-- disable window_picker for
				-- explorer to work well with
				-- window splits
				actions = {
					open_file = {
						window_picker = {
							enable = false,
						},
					},
				},
				filters = {
					custom = { ".DS_Store" },
				},
				git = {
					ignore = false,
				},
				on_attach = function(bufnr)
					local api = require("nvim-tree.api")

					-- Important: When you supply an `on_attach` function, nvim-tree won't
					-- automatically set up the default keymaps. To set up the default keymaps,
					-- call the `default_on_attach` function. See `:help nvim-tree-quickstart-custom-mappings`.
					api.config.mappings.default_on_attach(bufnr)

					local function opts(desc)
						return {
							desc = "nvim-tree: " .. desc,
							buffer = bufnr,
							noremap = true,
							silent = true,
							nowait = true,
						}
					end

					local preview = require("nvim-tree-preview")

					vim.keymap.set("n", "P", preview.watch, opts("Preview (Watch)"))
					vim.keymap.set("n", "<Esc>", preview.unwatch, opts("Close Preview/Unwatch"))
					vim.keymap.set("n", "<C-f>", function()
						return preview.scroll(4)
					end, opts("Scroll Down"))
					vim.keymap.set("n", "<C-b>", function()
						return preview.scroll(-4)
					end, opts("Scroll Up"))

					-- Option A: Smart tab behavior: Only preview files, expand/collapse directories (recommended)
					vim.keymap.set("n", "<Tab>", function()
						local ok, node = pcall(api.tree.get_node_under_cursor)
						if ok and node then
							if node.type == "directory" then
								api.node.open.edit()
							else
								preview.node(node, { toggle_focus = true })
							end
						end
					end, opts("Preview"))

					-- Option B: Simple tab behavior: Always preview
					-- vim.keymap.set('n', '<Tab>', preview.node_under_cursor, opts 'Preview')
					-- Default config:
					require("nvim-tree-preview").setup({
						-- Keymaps for the preview window (does not apply to the tree window).
						-- Keymaps can be a string (vimscript command), a function, or a table.
						--
						-- If a function is provided:
						--   When the keymap is invoked, the function is called.
						--   It will be passed a single argument, which is a table of the following form:
						--     {
						--       node: NvimTreeNode|NvimTreeRootNode, -- The tree node under the cursor
						--     }
						--   See the type definitions in `lua/nvim-tree-preview/types.lua` for a description
						--   of the fields in the table.
						--
						-- If a table, it must contain either an 'action' or 'open' key:
						--   Actions:
						--     { action = 'close', unwatch? = false, focus_tree? = true }
						--     { action = 'toggle_focus' }
						--     { action = 'select_node', target: 'next'|'prev' }
						--
						--   Open modes:
						--     { open = 'edit' }
						--     { open = 'tab' }
						--     { open = 'vertical' }
						--     { open = 'horizontal' }
						--
						-- To disable a default keymap, set it to false.
						-- All keymaps are set in normal mode. Other modes are not currently supported.
						keymaps = {
							["<Esc>"] = { action = "close", unwatch = true },
							["<Tab>"] = { action = "toggle_focus" },
							["<CR>"] = { open = "edit" },
							["<C-t>"] = { open = "tab" },
							["<C-v>"] = { open = "vertical" },
							["<C-x>"] = { open = "horizontal" },
							["<C-n>"] = { action = "select_node", target = "next" },
							["<C-p>"] = { action = "select_node", target = "prev" },
						},
						min_width = 50,
						min_height = 30,
						max_width = 185,
						max_height = 95,
						wrap = false, -- Whether to wrap lines in the preview window
						border = "rounded", -- Border style for the preview window
						zindex = 100, -- Stacking order. Increase if the preview window is shown below other windows.
						show_title = true, -- Whether to show the file name as the title of the preview window
						title_pos = "top-left", -- top-left|top-center|top-right|bottom-left|bottom-center|bottom-right
						title_format = " %s ",
						follow_links = true, -- Whether to follow symlinks when previewing files
						image_preview = {
							enable = false, -- Whether to preview images (for more info see Previewing Images section in README)
							patterns = { -- List of Lua patterns matching image file names
								".*%.png$",
								".*%.jpg$",
								".*%.jpeg$",
								".*%.gif$",
								".*%.webp$",
								".*%.avif$",
								-- Additional patterns:
								-- '.*%.svg$',
								-- '.*%.bmp$',
								-- '.*%.pdf$', (known to have issues)
							},
						},
						on_open = nil, -- fun(win: number, buf: number) called when the preview window is opened
						on_close = nil, -- fun() called when the preview window is closed
					})
				end,
			})
			local is_large = false

			-- Function to toggle Nvim Tree size
			local function toggle_nvim_tree_size()
				print("Toggling Nvim Tree size") -- Debugging output
				if is_large then
					vim.cmd("NvimTreeResize 35") -- Change this to your small width
					print("Nvim Tree size set to small") -- Debugging output
					is_large = false
				else
					vim.cmd("NvimTreeResize 500") -- Change this to your large width
					print("Nvim Tree size set to large") -- Debugging output
					is_large = true
				end
			end -- set keymaps
			local keymap = vim.keymap -- for conciseness
			keymap.set("n", "<leader>eb", toggle_nvim_tree_size, { desc = "Make side tree bigger" }) -- refresh file explorer

			keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
			keymap.set(
				"n",
				"<leader>ef",
				"<cmd>NvimTreeFindFileToggle<CR>",
				{ desc = "Toggle file explorer on current file" }
			) -- toggle file explorer on current file
			keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
			keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
		end,
	},
}
