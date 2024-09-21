return {
  -- "divagueame/aws-sam.nvim",
  dir = "/home/ma/web/plugins/aws-sam.nvim",
  dependencies = {
{
      -- "stevearc/resession.nvim"
}
    -- "rcarriga/nvim-notify",
  },
  -- event = "BufReadPost",
  dev = true,
  config = function()
    require("aws-sam").setup({
      keymaps = true,
    })
  end,
}
