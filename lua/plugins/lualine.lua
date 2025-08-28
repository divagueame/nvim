return {
  dependencies = { "nvim-tree/nvim-web-devicons" },
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
         fisabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        -- lualine_a = { "mode" },
        lualine_a = {""},
        -- lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = " ●",
              alternate_file = "#",
              directory = "",
            },
          },
        },
        -- lualine_x = { 'fileformat', 'filetype'},
        lualine_x = {
				{
					function()
						-- Function to get current linter (same logic as in lint-format.lua)
						local function get_project_linter_for_statusline()
							local eslint_configs = {
								".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml",
								".eslintrc.json", ".eslintrc", "eslint.config.js", "eslint.config.mjs"
							}
							
							for _, config in ipairs(eslint_configs) do
								if vim.fn.filereadable(config) == 1 then
									return "ESLint"
								end
							end
							
							-- Check package.json
							if vim.fn.filereadable("package.json") == 1 then
								local package_json = vim.fn.readfile("package.json")
								if package_json and #package_json > 0 then
									local content = table.concat(package_json, "")
									if content:find('"eslintConfig"') or content:find('"eslint"') then
										return "ESLint"
									end
								end
							end
							
							local biome_configs = { "biome.json", "biome.jsonc" }
							for _, config in ipairs(biome_configs) do
								if vim.fn.filereadable(config) == 1 then
									return "Biome"
								end
							end
							
							return "Biome" -- default
						end
						
						-- Only show for relevant file types
						local ft = vim.bo.filetype
						if ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact" or ft == "vue" then
							return "󰁨 " .. get_project_linter_for_statusline()
						end
						return ""
					end,
					color = { fg = "#61AFEF" }, -- Blue color
				},
			},
        lualine_y = { "progress" },
        -- lualine_z = { "location" },
        lualine_z = { "branch" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end,
}
