local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Delete a word backwards
-- keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
-- keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")



-- Save like your are used to
keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
keymap.set({ "i", "v", "n", "s" }, "<C-q>", "<cmd>wqa<Return>", { desc = "Save all buffers and quit" })

-- Exit insert mode
keymap.set("i", "jj", "<Esc>", { desc = "Exit Insert Mode" })
keymap.set("i", "jk", "<Esc>", { desc = "Exit Insert Mode" })

-- Move lines
-- Visual Mode
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap=true })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap=true })

-- Insert Mode
keymap.set('i', 'JJ', "<Esc>:m .+1<CR>==gi", { noremap=true })
keymap.set('i', 'KK', "<Esc>:m .-2<CR>==gi", { noremap=true })

-- Normal Mode
keymap.set('n', 'J', ":m .+1<CR>==", { noremap=true })
keymap.set('n', 'K', ":m .-2<CR>==", { noremap=true })


vim.api.nvim_set_keymap('n', '<S-a>', ':echo "Left Shift + a"<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-A>', ':echo "Right Shift + A"<CR>', { noremap = true, silent = true })
