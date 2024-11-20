-- return {}
return {
  -- "divagueame/aws-sam.nvim",
  dir = os.getenv("HOME") .. "/web/plugins/lacasitos.nvim",
  event = "VeryLazy",
  dependencies = {
    -- {
      -- "rcarriga/nvim-notify",
    -- }
  },
  -- event = "BufReadPost",
  dev = true,
  config = function()
    local lacasitos = require("lacasitos")

    lacasitos.setup({
      window  = {
        title = "My common custom title"
      }
    })

    vim.api.nvim_set_hl(0, 'MyCustomHighlight', { fg = '#FFD700', bg = '#005f87', bold = true })

    local animals = { "cat", "dog", "mouse"}

    vim.keymap.set("n", "<tab>df", function()
      -- local themes = { "gruvbox-material", "kanagawa-dragon" }
      local themes = {
        { label= "Gruvbox Material", value = "gruvbox-material" },
        { label= "Kanagawa Dragon", value = "kanagawa-dragon"}
      }
      local selected_theme = lacasitos.choose_option(themes)
      vim.cmd("colorscheme " .. selected_theme)
    end, { desc = "Change colorscheme" })

  end,
}
