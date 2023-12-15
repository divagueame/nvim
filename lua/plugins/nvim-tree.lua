return {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()

            require("nvim-tree").setup {
            view = {
                width = 30,
            },
             on_attach = my_on_attach
            }

            vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
        end
    }
