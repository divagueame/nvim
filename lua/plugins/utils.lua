-- HighlightCurrentWord
function HighlightCurrentWord()
  console.log();
  local cursor_word = vim.fn.expand("<cword>")
  vim.cmd("match Search /" .. cursor_word .. "/")

  vim.defer_fn(function()
    vim.cmd("match NONE")
  end, 1500)
end
vim.api.nvim_set_keymap('n', '<Leader>h', ':lua HighlightCurrentWord()<CR>', {--[[ noremap = true, silent = true ]]})


-- Quick console log
function InsertConsoleLog()
  local save_cursor = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_command("normal! oconsole.log();")
  vim.api.nvim_command("startinsert!")
  vim.api.nvim_win_set_cursor(0, {save_cursor[1]+1, 18})
end
vim.api.nvim_set_keymap('n', '<leader>cl', ':lua InsertConsoleLog()<CR>', {noremap = true, silent = true})


return {}
