local M = {}

function M.setup()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

  local dashboard = require "alpha.themes.dashboard"
  local function header()
    return {
[[                                                ]],
[[                                                ]],
[[     /\-/\                                      ]],
[[    /a a  \                                 _   ]],
[[   =\ Y  =/-~~~~~~-,_______________________/ )  ]],
[[     '^--'          ________________________/   ]],
[[       \           /                            ]],
[[       ||  |---'\  \                            ]],
[[      (_(__|   ((__|                            ]],
[[                                                ]],
[[                                                ]],
    }
  end

  dashboard.section.header.val = header()

  dashboard.section.buttons.val = {
--    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
--    dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
--    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }

  local function footer()
    local datetime = os.date "%d-%m-%Y | %H:%M:%S"
    local plugins_text = "\t"  .. datetime

    return plugins_text .. "\n" .. "Always Chiki" 
  end

  dashboard.section.footer.val = footer()

  dashboard.section.footer.opts.hl = "Constant"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Function"
  dashboard.section.buttons.opts.hl_shortcut = "Type"
  dashboard.opts.opts.noautocmd = true

  alpha.setup(dashboard.opts)
end

return M
