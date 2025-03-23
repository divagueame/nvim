local keymap = vim.keymap
local opts = { noremap = true, silent = true }

local modes = { "n", "x", "o" } -- Normal, Visual, Visual Block, Operator-pending

-- Movement keys for Colemak
-- vim.keymap.set(modes, "h", "h", opts) -- Same as QWERTY
-- vim.keymap.set(modes, "n", "j", opts)
-- vim.keymap.set(modes, "e", "k", opts)
-- vim.keymap.set(modes, "i", "l", opts)

-- Insert mode
-- keymap.set("n", "u", "i", opts)
-- keymap.set("n", "U", "I", opts)
-- keymap.set("n", "a", "a", opts)
-- keymap.set("n", "A", "A", opts)
--
-- keymap.set({ "n", "x" }, "b", "v")
-- keymap.set({ "n", "x" }, "B", "v")
-- Visual mode

-- Undo / Redo
-- keymap.set({ "n" }, "k", "u", opts)
-- keymap.set({ "n" }, "K", "<C-r>", opts)
--
-- Yank / Paste
-- keymap.set({ "n", "o", "x" }, "c", "y", opts)
-- keymap.set({ "n", "x" }, "v", "p", opts)

-- keymap.set("n", "l", "p", opts)
-- keymap.set("n", "y", "o", opts)

-- Save like your are used to
-- keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>silent! w<cr><esc>", { silent = true, desc = "Save file" })

-- Exit Neovim Enter + q
vim.api.nvim_set_keymap("n", "<CR>q", ":wqa<CR>", { noremap = true, silent = true, desc = "Save and Exit" })

-- vim.keymap.set("n", "v", "v", { noremap = true }) -- Ensure `v` enters visual mode
-- Move lines up and down
-- keymap.set("v", "N", ":m '>+1<CR>gv=gv", { noremap = true })
-- keymap.set("v", "E", ":m '<-2<CR>gv=gv", { noremap = true })
-- keymap.set("i", "JJ", "<Esc>:m .+1<CR>==gi", { noremap = true })
-- keymap.set("i", "KK", "<Esc>:m .-2<CR>==gi", { noremap = true })
-- keymap.set("n", "E", ":m .-2<CR>==", { noremap = true })
-- keymap.set("n", "N", ":m .+1<CR>==", { noremap = true })

-- Select all
-- keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })
--
-- -- Split window
keymap.set("n", "rr", ":split<Return>", opts)
keymap.set("n", "rv", ":vsplit<Return>", opts)
--
-- -- Close all other splits and focus on the current one
-- -- keymap.set('n', '<C-w>o', '', { noremap = true, silent = true })
--
-- -- Buffer navigation
-- vim.keymap.set("n", "<Tab>j", ":bnext<CR>", { desc = "Go to the next buffer" })
-- vim.keymap.set("n", "<Tab>k", ":bprev<CR>", { desc = "Go to the previous buffer" })
--
-- vim.keymap.set("n", "<Tab>m", ":tabnext<CR>", { desc = "Go to the next tab" })
-- vim.keymap.set("n", "<Tab>n", ":tabnew<CR>", { desc = "Open a new tab" })
-- vim.keymap.set("n", "<Tab>b", ":tabclose<CR>", { desc = "Close the current tab" })
function SaveAndCloseBuffer()
	vim.cmd("silent! write")
	vim.cmd("silent! bdelete")
end

keymap.set({ "v", "n" }, "<Tab>u", SaveAndCloseBuffer, { noremap = true, silent = true, desc = "Save & Close buffer" })
-- keymap.set("n", "<Tab>i", ":Telescope buffers<CR>", { noremap = true })
--
-- -- Delete all buffers but the current one
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>bq",
-- 	'<Esc>:%bdelete|edit #|normal`"<Return>',
-- 	{ desc = "Delete other buffers but the current one" }
-- )
--
--
-- -- Position cursor at the middle of the screen after scrolling half page
-- vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Scroll down half a page and center the cursor
-- vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Scroll up half a page and center the cursor
--
-- -- Resize panes
-- keymap.set("n", "<leader>wk", function()
-- 	vim.cmd("exe 'resize ' .. (winheight(0) + 6)")
-- end, vim.tbl_extend("force", opts, { desc = " + window height" }))
--
-- keymap.set("n", "<leader>wj", function()
-- 	vim.cmd("exe 'resize ' .. (winheight(0) - 6)")
-- end, vim.tbl_extend("force", opts, { desc = " - window height" }))
--
-- keymap.set("n", "<leader>wh", function()
-- 	vim.cmd("exe 'vertical resize ' .. (winwidth(0) + 6)")
-- end, vim.tbl_extend("force", opts, { desc = " + window width" }))
--
-- keymap.set("n", "<leader>wl", function()
-- 	vim.cmd("exe 'vertical resize ' .. (winwidth(0) - 6)")
-- end, vim.tbl_extend("force", opts, { desc = " - window width" }))
--
-- -- Toggle Diagnostics
-- local diagnostics_active = true
-- vim.keymap.set("n", "<leader>d", function()
-- 	diagnostics_active = not diagnostics_active
-- 	if diagnostics_active then
-- 		vim.diagnostic.show()
-- 	else
-- 		vim.diagnostic.hide()
-- 	end
-- end, vim.tbl_extend("force", opts, { desc = "Hide/Show Diagnostics" }))

-- Undo / Redo
-- keymap.set("n", "U", ":redo<cr>", opts)
-- keymap.set("n", "<C-r>", ':echo "Use U / u instead to do / redo"<cr>', opts)

-- Quickfix
-- vim.keymap.set("n", "qo", ":copen<CR>", { desc = "Open quickfix list" })
-- vim.keymap.set("n", "qc", ":cclose<CR>", { desc = "Close quickfix list" })
--
-- vim.keymap.set("n", "qj", ":cnext<CR>", { desc = "Next quickfix item" })
-- vim.keymap.set("n", "qk", ":cprev<CR>", { desc = "Previous quickfix item" })

-- Execute a command on each item in the quickfix list
-- vim.keymap.set("n", "<leader>qd", ":cdo ", { desc = "Execute command on quickfix items" })

-- Clear quickfix list
-- vim.keymap.set("n", "<leader>qx", function()
-- 	vim.fn.setqflist({})
-- 	print("Quickfix list cleared")
-- end, { desc = "Clear quickfix list" })

-- Deletes without adding to register
-- vim.api.nvim_set_keymap("n", "dd", '"_dd', { noremap = true })

-- Prevent losing yanked worked when pasting
-- keymap.set("v", "p", '"_dP', { noremap = true })

-- Start/Stop recording register
-- vim.api.nvim_set_keymap("n", "qq", "q", { noremap = true })
-- vim.api.nvim_set_keymap("n", "q", "<Nop>", { noremap = true }) -- Disable the default 'q' binding

---------------------------------------------------
-- Map CapsLock (F13) + g to some action
--
-- Add these lines to ~/.Xmodmap and run
--
-- remove Lock = Caps_Lock
-- keycode 66 = F13
--
-- Add this line to i3 config:
-- exec --no-startup-id xmodmap -e 'clear Lock' -e 'keycode 66 = F13'
---------------------------------------------------

-- -- Change Ctrl+w + o to call the print function
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<C-w>o",
-- 	':lua require("config.utils").Display_error("CAPS + v")<CR>',
-- 	{ noremap = true, silent = true }
-- )
-- vim.api.nvim_set_keymap("n", "<F6>v", ":only<CR>", { noremap = true, silent = true, desc = "Remove all splits" })
--
-- -- Move focus to the left split with CAPS + j
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<C-w>h",
-- 	':lua require("config.utils").Display_error("CAPS + j")<CR>',
-- 	{ noremap = true, silent = true }
-- )
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<F6>h",
-- 	":wincmd h<CR>",
-- 	{ noremap = true, silent = true, desc = "Move focus to the left split" }
-- )
--
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<F6>l",
-- 	":wincmd l<CR>",
-- 	{ noremap = true, silent = true, desc = "Move focus to the right split" }
-- )
--
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<F6>k",
-- 	":wincmd k<CR>",
-- 	{ noremap = true, silent = true, desc = "Move focus to the top split" }
-- )
--
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<F6>j",
-- 	":wincmd j<CR>",
-- 	{ noremap = true, silent = true, desc = "Move focus to the top split" }
-- )
--
-- -- Toggle diagnostics
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<C-b>",
-- 	":lua vim.diagnostic.enable(not vim.diagnostic.is_enabled())<CR>",
-- 	{ noremap = true, silent = true }
-- )
--
-- -- Show messages
-- vim.api.nvim_set_keymap("n", "<F6>m", ":messages<CR>", { noremap = true, silent = true })
--
-- -- Map Ctrl+b in insert mode to delete to the end of the word without leaving insert mode
-- vim.keymap.set("i", "<C-b>", "<C-o>de")
--
-- -- Accessories
-- -- Toggle display mode for cursor location
-- local display_cursor_mode = false
-- function ToggleCursorLocation()
-- 	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2D3B3B", fg = "#CFD9E6" })
-- 	vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#2D3B3B", fg = "#CFD9E6" })
-- 	display_cursor_mode = not display_cursor_mode
--
-- 	if display_cursor_mode then
-- 		vim.o.ruler = true -- Show cursor position in the status line
-- 		vim.o.cursorline = true -- Highlight the current line
-- 		vim.o.cursorcolumn = true -- Highlight the current column
-- 		print("Cursor location display: ON")
-- 	else
-- 		vim.o.ruler = false
-- 		vim.o.cursorline = false
-- 		vim.o.cursorcolumn = false
-- 		print("Cursor location display: OFF")
-- 	end
-- end
-- vim.keymap.set("n", "<leader>ac", ToggleCursorLocation, { desc = "Toggle cursor location display" })
--
-- -- Toggle line wrapping
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<leader>al",
-- 	":set wrap!<CR>",
-- 	{ noremap = true, silent = true, desc = "Toggle Line Wrap" }
-- )
-- vim.api.nvim_create_user_command("ToggleWrap", function()
-- 	vim.wo.wrap = not vim.wo.wrap
-- 	print("Line wrap is now " .. (vim.wo.wrap and "on" or "off"))
-- end, {})
--
-- -- References
-- vim.keymap.set("n", "gr", function()
-- 	local win = vim.api.nvim_get_current_win()
-- 	vim.lsp.buf.references(nil, {
-- 		on_list = function(items, title, context)
-- 			vim.fn.setqflist({}, " ", items)
-- 			vim.cmd.copen()
-- 			vim.api.nvim_set_current_win(win)
-- 		end,
-- 	})
-- end)
