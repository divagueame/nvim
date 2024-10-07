return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- change color for arrows in tree to light blue
--    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
--    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

    -- configure nvim-tree
    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
--              arrow_closed = "", -- arrow when folder is closed
--              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })
    local is_large = false

    -- Function to toggle Nvim Tree size
    local function toggle_nvim_tree_size()
      print("Toggling Nvim Tree size")  -- Debugging output
      if is_large then
        vim.cmd("NvimTreeResize 35")  -- Change this to your small width
        print("Nvim Tree size set to small")  -- Debugging output
        is_large = false
      else
        vim.cmd("NvimTreeResize 500")  -- Change this to your large width
        print("Nvim Tree size set to large")  -- Debugging output
        is_large = true
      end
    end    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    keymap.set("n", "<leader>eb", toggle_nvim_tree_size, { desc = "Make side tree bigger" }) -- refresh file explorer

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
  end,
}
