vim.api.nvim_set_hl(0, "YankColor", { fg = "#34495E", bg = "#2FCD7F" })
vim.cmd("highlight NotifyBackground guifg=#882230 guibg=NONE gui=bold")

--- Harpoon Panel
vim.api.nvim_set_hl(0, 'HarpoonSelectedOptionHL', { bg = "#121212", fg = "#2FCD7F", bold = true })
vim.api.nvim_set_hl(0, 'HarpoonOptionHL', { fg = "#f9000f", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, 'HarpoonFilesPanelHL', { fg = "#f0f00f", bg = "NONE", bold = true })

-- Customize the floating window's text and border
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e2e", fg = "#c0caf5" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1e1e2e", fg = "#a9b1d6" })

-- Dark background for floating windows with Gruvbox-compatible colors
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1d2021", fg = "#ebdbb2" })  -- Dark background, light text
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1d2021", fg = "#afff8f" }) -- Border with a softer color

-- Set the color of the title/tag at the top of floating windows
vim.api.nvim_set_hl(0, "Title", { fg = "#fabd2f", bg = "#1d2021", bold = true })  -- Gruvbox yellow on dark bg
