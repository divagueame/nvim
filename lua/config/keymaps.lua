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

-- Close all other splits and focus on the current one
keymap.set('n', '<C-w>o', '', { noremap = true, silent = true })

-- Buffer navigation
keymap.set('n', '<Tab>j', ":bnext<CR>", opts)
keymap.set('n', '<Tab>k', ":bprev<CR>", opts)
keymap.set({ "i", "v", "n" }, '<Tab>u', ":bd<CR>", opts)
keymap.set('n', '<Tab>i', ":buffers<CR>", opts)

-- Move half page
keymap.set('n', '<C-j>', ':normal! 20j<CR>', opts)
keymap.set('n', '<C-k>', ':normal! 20k<CR>', opts)

-- Move 6 lines
keymap.set('n', '<C-n>', ':normal! 5j<CR>', opts)
keymap.set('n', '<C-m>', ':normal! 5k<CR>', opts)


-- Resize panes
keymap.set('n', '<leader>wk', function()
  vim.cmd("exe 'resize ' .. (winheight(0) + 6)")
end, opts)

keymap.set('n', '<leader>wj', function()
  vim.cmd("exe 'resize ' .. (winheight(0) - 6)")
end, opts)

keymap.set('n', '<leader>wh', function()
  vim.cmd("exe 'vertical resize ' .. (winwidth(0) + 6)")
end, opts)

keymap.set('n', '<leader>wl', function()
  vim.cmd("exe 'vertical resize ' .. (winwidth(0) - 6)")
end, opts)

-- Toggle Diagnostics
local diagnostics_active = true
vim.keymap.set('n', '<leader>d', function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end)

-- Undo / Redo
keymap.set('n', 'U', ':redo<cr>', opts)
keymap.set('n', '<C-r>', ':echo "Use U / u instead to do / redo"<cr>', opts)

