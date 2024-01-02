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
      -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.tsserver.setup {
        capabilities = capabilities
      }
      lspconfig.rust_analyzer.setup {
        capabilities = capabilities
      }
      lspconfig.phpactor.setup{
        capabilities = capabilities
      }
      lspconfig.stimulus_ls.setup{
        capabilities = capabilities
      }

      -- Keymaps
      vim.keymap.set('n', '<leader>ek', vim.lsp.buf.hover, { desc = "LSP - Hover info"})
      vim.keymap.set('n', '<leader>em', vim.lsp.buf.definition, { desc = "LSP - Definition"})
      vim.keymap.set('n', '<leader>e,', vim.lsp.buf.references, { desc = "LSP - References"})
      vim.keymap.set('n', '<leader>e.', vim.lsp.buf.code_action, { desc = "LSP - Code action"})
    end
  }
}
