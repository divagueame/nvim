return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "ruby_lsp",
          -- "tsserver",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig_status, lspconfig = pcall(require, "lspconfig")
      if not lspconfig_status then
        return
      end

      local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if not cmp_nvim_lsp_status then
        return
      end

      local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set(
          "n",
          "<leader>nm",
          vim.lsp.buf.hover,
          vim.tbl_extend("force", opts, { desc = "LSP - Hover info" })
        )
        vim.keymap.set(
          "n",
          "<leader>em",
          vim.lsp.buf.definition,
          vim.tbl_extend("force", opts, { desc = "LSP - Definition" })
        )
        vim.keymap.set(
          "n",
          "<leader>e,",
          vim.lsp.buf.references,
          vim.tbl_extend("force", opts, { desc = "LSP - References" })
        )
        vim.keymap.set(
          "n",
          "<leader>e.",
          vim.lsp.buf.code_action,
          vim.tbl_extend("force", opts, { desc = "LSP - Code action" })
        )
      end

      local servers = {
        "lua_ls",
        "rust_analyzer",
        "ruby_lsp",
        "solargraph",
        "gopls",
        "phpactor",
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end

      lspconfig.tailwindcss.setup({})
      lspconfig.stimulus_ls.setup({
        cmd = { "node", "/home/ma/web/source/stimulus-lsp/server/out/server.js", "--stdio" },
        capabilities = capabilities,
      })
      -- lspconfig.tsserver.setup {
      --   capabilities = capabilities
      -- }
      -- lspconfig.volar.setup({
      -- 	capabilities = capabilities,
      -- 	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
      -- 	init_options = {
      -- 		typescript = {
      -- 			tsdk = "/usr/lib/node_modules/typescript/lib",
      -- 		},
      -- 	},
      -- })
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
}
