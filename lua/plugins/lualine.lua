return {
  dependencies = { "nvim-tree/nvim-web-devicons" },
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
         fisabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        -- lualine_a = { "mode" },
        lualine_a = {""},
        -- lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = " ●",
              alternate_file = "#",
              directory = "",
            },
          },
        },
        -- lualine_x = { 'fileformat', 'filetype'},
        lualine_x = {},
        lualine_y = { "progress" },
        -- lualine_z = { "location" },
        lualine_z = { "branch" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end,
}
