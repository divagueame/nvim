local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Insert --
-- Press jk fast to exit insert mode 
keymap("i", "jj", "<ESC>", opts)

-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Quicksave
keymap("n", "<S-s>", ":w<CR>", opts)

-- Quicksave quit
keymap("n", "<leader>q", ":wqa<CR>", opts)
--- 


