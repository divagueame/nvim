-- return {}
return {
  -- "divagueame/aws-sam.nvim",
  dir = os.getenv("HOME") .. "/web/plugins/aws-sam.nvim",
  dependencies = {
    {
      "rcarriga/nvim-notify",
    }
  },
  -- event = "BufReadPost",
  dev = true,
  config = function()
    require("aws-sam").setup({
      keymaps = true,
    })
  end,
}
