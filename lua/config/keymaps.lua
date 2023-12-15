local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Save like your are used to
keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
keymap.set({ "i", "v", "n", "s" }, "<C-q>", "<cmd>wqa<Return>", { desc = "Save all buffers and quit" })

-- Exit insert mode
keymap.set("i", "jj", "<Esc>", { desc = "Exit Insert Mode" })
keymap.set("i", "jk", "<Esc>", { desc = "Exit Insert Mode" })

-- Move lines
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap=true })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap=true })
keymap.set('i', 'JJ', "<Esc>:m .+1<CR>==gi", { noremap=true })
keymap.set('i', 'KK', "<Esc>:m .-2<CR>==gi", { noremap=true })
keymap.set('n', 'J', ":m .+1<CR>==", { noremap=true })
keymap.set('n', 'K', ":m .-2<CR>==", { noremap=true })

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Close buffer
keymap.set({ "i", "v", "n" }, "<C-c>", "<cmd>bd<cr><esc>", opts)

-- Close all other splits and focus on the current one
keymap.set('n', 'so', '<C-w>o', { noremap = true, silent = true })
