-- plugins/rest.lua
return {
  "rest-nvim/rest.nvim",
  dependencies = { { "nvim-lua/plenary.nvim" } },
  config = function()
    require("rest-nvim").setup({
      -- Open request results in a horizontal split
      result_split_horizontal = false,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = false,
      encode_url = false,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        show_http_info = true,
        show_headers = true,
      },
      -- Jump to request line on run
      jump_to_request = false,
      env_file = ".env",
      custom_dynamic_variables = {},
      yank_dry_run = true,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "http",
      callback = function()
        local buff = tonumber(vim.fn.expand "<abuf>", 10)
        vim.keymap.set(
          "n",
          "<leader>hh",
          function()
            require('rest-nvim').run()
          end,
          { noremap = true, buffer = buff, desc = "Run near http request" }
        )
        vim.keymap.set(
          "n",
          "<leader>hj",
          function()
            require('rest-nvim').last()
          end,
          { noremap = true, buffer = buff, desc = "Run last http resquest" }
        )
        vim.keymap.set("n",
          "<leader>hu",
          function()
            require('rest-nvim').run(true)
          end,
          { noremap = true, buffer = buff, desc = "Preview http curl" })
      end,
    })



  end
}
