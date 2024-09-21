return {
  'b0o/incline.nvim',
  config = function()

    vim.api.nvim_set_hl(0, 'CustomInclineHighlight', { fg = "#ffffff", bg = "#333333", bold = true })

    require('incline').setup {
      highlight = {
        groups = {
          InclineNormal = {
            default = true,
            group = "CustomInclineHighlight"
          },
          InclineNormalNC = {
            default = true,
            group = "CustomInclineHighlight"
          }
        }
      },
      render = "basic",
      window = {
        margin = {
          horizontal = 1,
          vertical = 1
        },
        options = {
          signcolumn = "no",
          wrap = false
        },
        overlap = {
          borders = true,
          statusline = false,
          tabline = false,
          winbar = false
        },
        padding = 1,
        padding_char = " ",
        placement = {
          horizontal = "right",
          vertical = "top"
        },
        width = "fit",
        winhighlight = {
          active = {
            EndOfBuffer = "None",
            Normal = "InclineNormal",
            Search = "None"
          },
          inactive = {
            EndOfBuffer = "None",
            Normal = "InclineNormalNC",
            Search = "None"
          }
        },
        zindex = 50
      }
    }
  end,
  -- Optional: Lazy load Incline
  event = 'VeryLazy',
}
