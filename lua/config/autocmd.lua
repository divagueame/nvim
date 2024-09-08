vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.md" },
  callback = function()
    vim.fn.system("prettier --write " .. vim.fn.expand("%"))
    vim.cmd("edit")
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "markdown" then
      vim.lsp.buf.format()
    end
  end,
})

local yank_group = vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = "*",
  group = yank_group,
  callback = function()
    vim.highlight.on_yank({ higroup = "YankColor", timeout = 200 })
  end,
})
