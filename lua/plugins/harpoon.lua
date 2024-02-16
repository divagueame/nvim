local function notify(msg)
  local arg_type = type(msg)

  if arg_type == 'string' then
    local output = 'echohl Normal | echohl ErrorMsg | echo "' .. msg .. '" | echohl None'
    vim.api.nvim_command(output)
  elseif arg_type == 'table' then
    local current_file = vim.fn.bufname()
    local color = ""
    local text = ""
    local file_list = {}

    for _, item in ipairs(msg) do
      if item.value  == current_file then
        text = " *" .. " " .. item.value .. " "
        color = "ModeMsg"
      else
        text = " | " .. item.value .. " | "
        color = "CursorLineSign"
      end
      table.insert(file_list, {text, color})
    end

    vim.api.nvim_echo(file_list, false, {})
    vim.defer_fn(function() vim.api.nvim_command("echo") end, 2500) -- Clear message timer
  end
end


return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  requires = { {"nvim-lua/plenary.nvim"} },
  config =  function()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>aa", function() harpoon:list():append() end)
    vim.keymap.set("n", "<leader>ah", function() harpoon:list():remove() end)
    vim.keymap.set("n", "<leader>au", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    -- vim.keymap.set("n", "<leader>aj", function() harpoon:list():select(1) end)
    -- vim.keymap.set("n", "<leader>ak", function() harpoon:list():select(2) end)
    -- vim.keymap.set("n", "<leader>al", function() harpoon:list():select(3) end)
    -- vim.keymap.set("n", "<leader>a;", function() harpoon:list():select(4) end)

    vim.keymap.set("n", "<leader>ak", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<leader>aj", function()
      local files = harpoon:list()

      if false == nil then
      -- if next(files.items) == nil then
        local msg = 'Ah No files on the list'
        notify(msg)
        return
      else
        notify(files.items)

        local current_file = vim.fn.bufname()
        local last_value

        for _, item in ipairs(harpoon:list().items) do
          last_value = item.value
        end

        if last_value == current_file then
          harpoon:list():select(1)
        else
          harpoon:list():next()
        end
      end

    end)
  end
}
