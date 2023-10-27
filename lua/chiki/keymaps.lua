local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

vim.keymap.set('n', '<C-b>', '<Cmd>Neotree toggle<CR>')
-- keymap('n', '<Leader>fe', '<Cmd>Neotree toggle<CR>', default_opts)

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>", default_opts)
-- keymap("t", "jk", "<C-\\><C-n>", default_opts)


-- Switch buffer
keymap("n", "<S-h>", ":bprevious<CR>", default_opts)
keymap("n", "<S-l>", ":bnext<CR>", default_opts)




keymap('n', '<Leader>q', [[<Cmd>Neotree close<CR>:wa<CR>:q<CR>]], default_opts)
keymap('i', '<Leader>q', [[<Esc><CR>:wa<CR>:q<CR>]], default_opts)
keymap('n', '<Leader>w', [[:wa<CR>]], default_opts)






