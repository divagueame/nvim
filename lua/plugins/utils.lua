function HighlightCurrentWord()
  local cursor_word = vim.fn.expand("<cword>")

  vim.cmd("nohlsearch")
  vim.cmd("match Search /" .. cursor_word .. "/")

  local bufnr = vim.fn.bufnr("%")

  local timer = vim.loop.new_timer()
  timer:start(1000, 0, vim.schedule_wrap(function()
    vim.api.nvim_buf_clear_highlight(bufnr, -1, 1, -1)
    timer:close()
  end))

end


vim.api.nvim_set_keymap('n', '<Leader>h', ':lua HighlightCurrentWord()<CR>', {noremap = true, silent = true})

return {}
