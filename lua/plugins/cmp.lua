return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-path", -- source for file system paths
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip", -- snippet engine
      "saadparwaiz1/cmp_luasnip", -- for autocompletion
      "rafamadriz/friendly-snippets", -- useful snippets
      "onsails/lspkind.nvim", -- vs-code like pictograms
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-vsnip'},
      {'hrsh7th/vim-vsnip'},
      {"hrsh7th/cmp-nvim-lsp"},
    },

    config = function()
      local cmp = require("cmp")
      local ls = require("luasnip")

      -- vim.keymap.set({"i"}, "<C-K>", function() luasnip.expand() end, {silent = true})
      -- vim.keymap.set({"i", "s"}, "<C-L>", function() luasnip.jump( 1) end, {silent = true})
      -- vim.keymap.set({"i", "s"}, "<C-J>", function() luasnip.jump(-1) end, {silent = true})
      -- vim.keymap.set({"i", "s"}, "<C-E>", function()
      --   if luasnip.choice_active() then
      --     luasnip.change_choice(1)
      --   end
      -- end, {silent = true})

      -- require("luasnip.loaders.from_vscode").lazy_load({ paths =  "~/.config/nvim/lua/snippets" })
      -- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/Luasnip" })
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
      
      --

      -- Autopairs config
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },

        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            ls.lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ["<C-e>"] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif ls.expand_or_jumpable() then
            ls.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif ls.jumpable(-1) then
            ls.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- snippets
          { name = "buffer" }, -- text within current buffer
          { name = "path" }, -- file system paths
        }),
        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          fields = {'abbr', 'kind', 'menu'},
          format = function(entry, item)
            -- Apply lspkind formatting
            local lspkind_format = require("lspkind").cmp_format({
              maxwidth = 50,
              ellipsis_char = "...",
            })
            lspkind_format(entry, item)

            --Tailwind colorized
            require("tailwindcss-colorizer-cmp").formatter(entry, item)

            -- Source Icons
            local menu_icon = {
              nvim_lsp = '[🍕]',
              luasnip = '-> SNIP',
              buffer = '+',
              PATH = '[ ⤴⤴⤴ ⤴  ]',
            }
            item.menu = menu_icon[entry.source.name]

            return item
          end
        },
      })
    end
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  }
}
