-- -- Leader key
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
--
-- -- disable netrw at the very start of your init.lua to allow nvim-tree
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
--
-- -- Line number
-- vim.opt.number = true
-- vim.opt.relativenumber = true
--
-- -- Split target
-- vim.opt.splitbelow = true
-- vim.opt.splitright = true
--
-- -- Line wrap
-- vim.opt.wrap = false
--
-- -- Hide Model on cmd line
-- vim.opt.showmode = false
--
-- -- Tab
-- vim.opt.expandtab = true
-- vim.opt.tabstop = 2
-- vim.opt.shiftwidth = 2
--
-- Clipboard
vim.opt.clipboard = "unnamedplus"
--
-- -- Scroll offset - Max will keep the scroll centered when possible
-- vim.opt.scrolloff = 12
--
-- -- Split when sustitute
-- vim.opt.inccommand = "split"
--
-- -- Ignore case when search / :commands
-- vim.opt.ignorecase = true
--
-- -- Set highlight on search
-- vim.o.hlsearch = false
--
-- vim.opt.termguicolors = true
--
-- -- Signs columns width
-- vim.opt.signcolumn = "yes"
--
-- -- enable persistent undo
-- vim.opt.undofile = true
--
-- vim.opt.guifont = "monospace:h17"
-- vim.opt.shortmess:append("I")
-- -- vim.cmd "set whichwrap+=<,>,[,],h,l"
--
-- -- sync buffers automatically
-- vim.opt.autoread = true
-- -- disable neovim generating a swapfile and showing the error
-- vim.opt.swapfile = false
--
-- -- Remove 'file saved message'
-- vim.opt.shortmess:append("ac")



vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 4 -- Amount to indent with << and >>
vim.opt.tabstop = 4 -- How many spaces are shown per Tab
vim.opt.softtabstop = 4 -- How many spaces are applied when pressing Tab

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true -- Keep identation from previous line

-- Enable break indent
vim.opt.breakindent = true

-- Always show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Show line under cursor
vim.opt.cursorline = true

-- Store undos between sessions
vim.opt.undofile = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }




-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

