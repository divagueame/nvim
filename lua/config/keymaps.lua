local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Save like your are used to
keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>silent! w<cr><esc>", { silent = true, desc = "Save file" })
keymap.set({ "i", "v", "n", "s" }, "<C-q>", "<cmd>wqa<Return>", { desc = "Save all buffers and quit" })

-- Prevent losing yanked worked when pasting
keymap.set("v", "p", '"_dP', { noremap = true })

-- Exit insert mode
-- keymap.set("i", "jj", "<Esc>", { desc = "Exit Insert Mode" })
keymap.set("i", "jk", "<Esc>", { desc = "Exit Insert Mode" })

-- Move lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })
keymap.set("i", "JJ", "<Esc>:m .+1<CR>==gi", { noremap = true })
keymap.set("i", "KK", "<Esc>:m .-2<CR>==gi", { noremap = true })
keymap.set("n", "J", ":m .+1<CR>==", { noremap = true })
keymap.set("n", "K", ":m .-2<CR>==", { noremap = true })

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Close all other splits and focus on the current one
-- keymap.set('n', '<C-w>o', '', { noremap = true, silent = true })

-- Buffer keybindings
-- keymap.set("n", "<C-p>", "<cmd>echo 'meow'<CR>", opts)
-- keymap.set("n", "<C-[>", "<cmd>echo 'meow'<CR>", opts)
-- keymap.set("n", "<C-h>", "<cmd>echo 'meow'<CR>", opts)

-- Buffer navigation
keymap.set("n", "<Tab>j", ":bnext<CR>", opts)
keymap.set("n", "<Tab>k", ":bprev<CR>", opts)
keymap.set({ "i", "v", "n" }, "<Tab>u", ":bd<CR>", opts)
-- keymap.set("n", "<Tab>i", ":buffers<CR>", opts)
keymap.set("n", "<Tab>i", ":Telescope buffers<CR>", { noremap = true })

-- Move half page
keymap.set("n", "<C-j>", ":normal! 20j<CR>", opts)
keymap.set("n", "<C-k>", ":normal! 20k<CR>", opts)

-- Move 6 lines
-- keymap.set("n", "<C-n>", ":normal! 5j<CR>", opts)
-- keymap.set("n", "<C-m>", ":normal! 5k<CR>", opts)

-- Resize panes
keymap.set("n", "<leader>wk", function()
	vim.cmd("exe 'resize ' .. (winheight(0) + 6)")
end, vim.tbl_extend("force", opts, { desc = " + window height" }))

keymap.set("n", "<leader>wj", function()
	vim.cmd("exe 'resize ' .. (winheight(0) - 6)")
end, vim.tbl_extend("force", opts, { desc = " - window height" }))

keymap.set("n", "<leader>wh", function()
	vim.cmd("exe 'vertical resize ' .. (winwidth(0) + 6)")
end, vim.tbl_extend("force", opts, { desc = " + window width" }))

keymap.set("n", "<leader>wl", function()
	vim.cmd("exe 'vertical resize ' .. (winwidth(0) - 6)")
end, vim.tbl_extend("force", opts, { desc = " - window width" }))

-- Toggle Diagnostics
local diagnostics_active = true
vim.keymap.set("n", "<leader>d", function()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		vim.diagnostic.show()
	else
		vim.diagnostic.hide()
	end
end, vim.tbl_extend("force", opts, { desc = "Hide/Show Diagnostics" }))

-- Undo / Redo
keymap.set("n", "U", ":redo<cr>", opts)
keymap.set("n", "<C-r>", ':echo "Use U / u instead to do / redo"<cr>', opts)

-- Quickfix
vim.keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "Close quickfix list" })

vim.keymap.set("n", "]q", ":cnext<CR>", { desc = "Next quickfix item" })
vim.keymap.set("n", "[q", ":cprev<CR>", { desc = "Previous quickfix item" })

-- Execute a command on each item in the quickfix list
vim.keymap.set("n", "<leader>qd", ":cdo ", { desc = "Execute command on quickfix items" })

-- Clear quickfix list
vim.keymap.set("n", "<leader>qx", function()
	vim.fn.setqflist({})
	print("Quickfix list cleared")
end, { desc = "Clear quickfix list" })

-- Deletes without adding to register
vim.api.nvim_set_keymap("n", "dd", '"_dd', { noremap = true })
