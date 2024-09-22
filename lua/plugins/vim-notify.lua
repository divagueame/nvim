return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      background_colour = "NotifyBackground",
      fps = 30,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },
      level = 2,
      minimum_width = 50,
      time_formats = {
        notification = "%T",
        notification_history = "%FT%T",
      },
      top_down = true,
      stages = "static",
      render = "wrapped-compact",
      -- render = "minimal",
      timeout = 8000,
      on_open = function(win)

        local dismiss = function ()
          require('notify').dismiss({})
        end
        vim.keymap.set('',  '<Esc>', dismiss, {silent = true})
      end,
    })

  end,
  keys = {
    {
      '<F13>i', ':Telescope notify theme=dropdown<CR>', { noremap = true, silent = true }
    }
  },
}
