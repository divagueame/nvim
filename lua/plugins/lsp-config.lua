return {
  -- Mason
  { "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  -- Mason-lsp config
  {"williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "tsserver"
        }
      })
    end
  },
  -- nvim-lspconfig
  {"neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.tsserver.setup {}
      lspconfig.rust_analyzer.setup {}
      lspconfig.phpactor.setup{}

      -- Keymaps
      vim.keymap.set('n', '<leader>ek', vim.lsp.buf.hover, {})
      vim.keymap.set('n', '<leader>em', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>e,', vim.lsp.buf.references, {})
      vim.keymap.set('n', '<leader>e.', vim.lsp.buf.code_action, {})
    end
  }
}
