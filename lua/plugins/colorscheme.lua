-- return {
-- 	"rebelot/kanagawa.nvim",
-- 	config = function()
-- 		-- vim.cmd.colorscheme("kanagawa-wave")
-- 		vim.cmd.colorscheme("kanagawa-dragon")
-- 	end,
-- }
local opts = {
  styles = {
    type = { bold = true },
    lsp = { underline = false },
    match_paren = { underline = true },
  },
}

local function config()
  local plugin = require "no-clown-fiesta"
  plugin.setup(opts)
  -- return plugin.load()
end

return {{
  "aktersnurra/no-clown-fiesta.nvim",
  priority = 1000,
  config = config,
  lazy = false,
},
{
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
    vim.g.gruvbox_material_background = 'hard'
		vim.g.gruvbox_material_enable_italic = true
		vim.cmd.colorscheme("gruvbox-material")
	end,
}
}
-- return { "ellisonleao/gruvbox.nvim",
--   priority = 1000 ,
--   opts = {},
--   config = function()
--     -- Default options:
--     require("gruvbox").setup({
--       terminal_colors = true, -- add neovim terminal colors
--       undercurl = true,
--       underline = true,
--       bold = true,
--       italic = {
--         strings = true,
--         emphasis = true,
--         comments = true,
--         operators = false,
--         folds = true,
--       },
--       strikethrough = true,
--       invert_selection = false,
--       invert_signs = false,
--       invert_tabline = false,
--       invert_intend_guides = false,
--       inverse = true, -- invert background for search, diffs, statuslines and errors
--       contrast = "", -- can be "hard", "soft" or empty string
--       palette_overrides = {},
--       overrides = {},
--       dim_inactive = false,
--       transparent_mode = false,
--     })
--     vim.cmd("colorscheme gruvbox")
--   end
-- }
