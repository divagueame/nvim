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
          "tsserver",
        },
      })
    end,
  },
  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
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
        capabilities = capabilities,
      })
      lspconfig.solargraph.setup({
        capabilities = capabilities,
      })
      lspconfig.gopls.setup({})
      -- lspconfig.tsserver.setup {
      --   capabilities = capabilities
      -- }
      lspconfig.volar.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
        init_options = {
          typescript = {
            tsdk = "/usr/lib/node_modules/typescript/lib",
          },
        },
      })

      lspconfig.ruby_lsp.setup({
        cmd = { "bundle", "exec", "ruby-lsp" },
        on_attach = function(client, buffer)
          local callback = function()
            local params = vim.lsp.util.make_text_document_params(buffer)

            client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
              if err then
                return
              end

              vim.lsp.diagnostic.on_publish_diagnostics(
                nil,
                vim.tbl_extend("keep", params, { diagnostics = result.items }),
                { client_id = client.id }
              )
            end)
          end

          callback() -- call on attach

          vim.api.nvim_create_autocmd(
            { "BufEnter", "BufWritePre", "BufReadPost", "InsertLeave", "TextChanged" },
            {
              buffer = buffer,
              callback = callback,
            }
          )
        end,
      })
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
