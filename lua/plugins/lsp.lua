return {
  -- Mason
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  -- Mason-lsp config
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "ruby_lsp",
          "tsserver",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.tailwindcss.setup({})
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
      })
      lspconfig.phpactor.setup({
        capabilities = capabilities,
      })
      lspconfig.stimulus_ls.setup({
        cmd = { "node", "/home/ma/web/source/stimulus-lsp/server/out/server.js", "--stdio" },
        capabilities = capabilities,
      })
      lspconfig.solargraph.setup({
        capabilities = capabilities,
      })
      lspconfig.gopls.setup({})
      lspconfig.ruby_lsp.setup({})
      -- lspconfig.tsserver.setup {
      --   capabilities = capabilities
      -- }
      -- lspconfig.volar.setup({
      --   capabilities = capabilities,
      --   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
      --   init_options = {
      --     typescript = {
      --       tsdk = "/usr/lib/node_modules/typescript/lib",
      --     },
      --   },
      -- })

      -- Keymaps
      vim.keymap.set("n", "<leader>ek", vim.lsp.buf.hover, { desc = "LSP - Hover info" })
      vim.keymap.set("n", "<leader>em", vim.lsp.buf.definition, { desc = "LSP - Definition" })
      vim.keymap.set("n", "<leader>e,", vim.lsp.buf.references, { desc = "LSP - References" })
      vim.keymap.set("n", "<leader>e.", vim.lsp.buf.code_action, { desc = "LSP - Code action" })

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      -- Setup required for ufo
      local capabilities =
      require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
    end,
  },
}
