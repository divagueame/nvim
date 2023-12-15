return {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
          local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<Leader>f", function() builtin.find_files({ no_ignore = true }) end, {})
            vim.keymap.set("n", "<Leader>g", function() builtin.live_grep({ no_ignore = true }) end, {})
      end
   } 
