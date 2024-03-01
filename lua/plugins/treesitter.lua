return {
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
  },
  {
    'nvim-treesitter/playground',
    config = function()
      require "nvim-treesitter.configs".setup {
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        }
      }
    end
  }
}
