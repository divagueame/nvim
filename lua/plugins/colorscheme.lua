-- return {
-- 	"rebelot/kanagawa.nvim",
-- 	config = function()
-- 		-- vim.cmd.colorscheme("kanagawa-wave")
-- 		vim.cmd.colorscheme("kanagawa-dragon")
-- 	end,
-- }
return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
    vim.g.gruvbox_material_background = 'hard'
		vim.g.gruvbox_material_enable_italic = true
		vim.cmd.colorscheme("gruvbox-material")
	end,
}
