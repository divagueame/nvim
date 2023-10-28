local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>", default_opts)
-- keymap("t", "jk", "<C-\\><C-n>", default_opts)


keymap("n", "<S-h>", ":bprevious<CR>", default_opts)
keymap("n", "<S-l>", ":bnext<CR>", default_opts)



-- Save
keymap('n', '<Leader>w', [[:wa<CR>]], default_opts)
-- keymap('i', '<Leader>w', [[<Esc><CR>:wa<CR>i]], default_opts)

pollas
keymap('n', '<Leader>q', [[:wa<CR>:qa<CR>]], default_opts)
-- keymap('i', '<Leader>wf', [[<Esc><CR>:wa<CR>:qa<CR>]], default_opts)
 
-- Toggle File tree
keymap('n', '<Leader>fe', [[<cmd>NvimTreeToggle<cr>]], default_opts)

-- Vimspector
keymap('n', '<Leader>dd', [[:call vimspector#Launch()<CR>]], default_opts);
keymap('n', '<Leader>dr', [[:call vimspector#Reset()<CR>]], default_opts);
keymap('n', '<Leader>dc', [[:call vimspector#Continue()<CR>]], default_opts);
keymap('n', '<Leader>dt', [[:call vimspector#ToggleBreakpoint()<CR>]], default_opts);
keymap('n', '<Leader>dT', [[:call vimspector#ClearBreakpoints()<CR>]], default_opts);

keymap('n', '<Leader>dk', [[<Plug>VimspectorRestart]], default_opts);
keymap('n', '<Leader>dh', [[<Plug>VimspectorStepOut]], default_opts);
keymap('n', '<Leader>dl', [[<Plug>VimspectorStepInto]], default_opts);
keymap('n', '<Leader>dj', [[<Plug>VimspectorStepOver]], default_opts);

