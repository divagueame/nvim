local options = {
  clipboard = "unnamedplus",
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  pumheight = 10,
  showtabline = 2,
  tabstop = 2,
  shiftwidth = 2,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  number = true,
  relativenumber = true,
  list = false,
	fillchars = 'eob: '
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
