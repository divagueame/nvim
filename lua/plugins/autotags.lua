return  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup({
        filetypes = { "html" , "xml", "eruby", "embedded_template" }
      })
    end
  }
