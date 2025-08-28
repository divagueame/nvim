return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	-- tag = "v2.15", -- uncomment to pin to a specific release
	init = function()
		-- Use Skim for macOS (not zathura)
		vim.g.vimtex_view_method = "skim"

		-- Compiler settings
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			build_dir = "",
			callback = 1,
			continuous = 1,
			executable = "latexmk",
			options = {
				"-verbose",
				"-file-line-error",
				"-synctex=1",
				"-interaction=nonstopmode",
			},
		}

		-- Optional: Disable some default mappings if you want
		-- vim.g.vimtex_mappings_enabled = 0

		-- Optional: Set the quickfix to open automatically on errors
		vim.g.vimtex_quickfix_mode = 0
	end,
}
