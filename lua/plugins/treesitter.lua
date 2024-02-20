return 
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "windwp/nvim-ts-autotag" },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "http", "json", "ruby", "php" },
        auto_install = true,
        highlight = {
          enable = true
        },
        indent = { enable = true },
        incremental_selection =  {
          enable = true,
          keymaps = {
            init_selection = "<leader>ss",
            node_incremental = "<leader>sj",
            scope_incremental = "<leader>sh",
            node_decremental = "<leader>sk",
          },
        },

        autotag = {
          enable = true,
        },
      })
    end
  }
