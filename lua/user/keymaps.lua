local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap 's' to avoid i3 conflicts
keymap("n", "<leader>s", ":normal! s<CR>", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jj", "<ESC>", opts)

-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
keymap("n", "<leader>gg", ":bnext<cr>", opts)
keymap("n", "<leader>gf", ":bd<cr>", opts)
keymap("n", "<leader>gr", "<C-w>w", opts)

-- Quicksave
keymap("n", "<S-s>", ":w<CR>", opts)

-- Quicksave quit
keymap("n", "<leader>q", ":wqa<CR>", opts)
---

-- Formatter
-- keymap("n", "<S-s>", ":FormatWrite<CR>", opts)
