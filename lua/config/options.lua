-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' ' 

-- disable netrw at the very start of your init.lua to allow nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Line number
vim.opt.number = true
vim.opt.relativenumber = true

-- Split target
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Line wrap
vim.opt.wrap = false

-- Hide Model on cmd line
vim.opt.showmode = false

-- Tab
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Scroll offset - Max will keep the scroll centered when possible
vim.opt.scrolloff = 12

-- Split when sustitute
vim.opt.inccommand = "split"

-- Ignore case when search / :commands
vim.opt.ignorecase = true

-- Set highlight on search
vim.o.hlsearch = false

vim.opt.termguicolors = true

-- Signs columns width
vim.opt.signcolumn="yes"

-- enable persistent undo
vim.opt.undofile=true

vim.opt.guifont="monospace:h17"

-- vim.cmd "set whichwrap+=<,>,[,],h,l"
