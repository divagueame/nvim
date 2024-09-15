vim.cmd([[
    highlight NotifyBorder guifg=#ff0000 guibg=#00f000
]])
-- highlight NotifyERRORBorder guifg=#8B8B8B
-- highlight NotifyERRORBorder guifg=#8B8B8B
-- highlight NotifyWARNBorder guifg=#8B8B8B
-- highlight NotifyINFOBorder guifg=#8B8B8B
-- highlight NotifyDEBUGBorder guifg=#8B8B8B
-- highlight NotifyTRACEBorder guifg=#8B8B8B
-- highlight NotifyERRORIcon guifg=#F70067
-- highlight NotifyWARNIcon guifg=#F79000
-- highlight NotifyINFOIcon guifg=#A9FF68
-- highlight NotifyDEBUGIcon guifg=#8B8B8B
-- highlight NotifyTRACEIcon guifg=#D484FF
-- highlight NotifyERRORTitle  guifg=#F70067
-- highlight NotifyWARNTitle guifg=#F79000
-- highlight NotifyINFOTitle guifg=#A9FF68
-- highlight NotifyDEBUGTitle  guifg=#8B8B8B
-- highlight NotifyTRACETitle  guifg=#D484FF
-- highlight link NotifyERRORBody Normal
-- highlight link NotifyWARNBody Normal
-- highlight link NotifyINFOBody Normal
-- highlight link NotifyDEBUGBody Normal
-- highlight link NotifyTRACEBody Normal

return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      stages = "static",
      render = "minimal",
      timeout = 4000,
      -- background_color = "NotifyBorder",
      on_open = function(win)
        local buf = vim.api.nvim_win_get_buf(win)
        vim.api.nvim_set_hl(0, "NotifyBorder", { fg = "#2d2d2d" }) -- Change #ff0000 to your desired border color

        -- Link notify border highlights
        vim.api.nvim_set_hl(0, "NotifyINFOBorder", { link = "NotifyBorder" })
        vim.api.nvim_set_hl(0, "NotifyWARNBorder", { link = "NotifyBorder" })
        vim.api.nvim_set_hl(0, "NotifyERRORBorder", { link = "NotifyBorder" })
        vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { link = "NotifyBorder" })

        vim.api.nvim_set_hl(0, "NotifyERRORBody", { link = "NotifyBorder" })
        vim.api.nvim_set_hl(0, "NotifyWARNBody", { link = "NotifyBorder" })
        vim.api.nvim_set_hl(0, "NotifyINFOBody", { link = "NotifyBorder" })
        vim.api.nvim_set_hl(0, "NotifyERRORBody", { link = "NotifyBorder" })
        vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { link = "NotifyBorder" })

        -- Apply custom border
        -- vim.api.nvim_buf_set_option(buf, "winhighlight", "Normal:NotifyBorder")
        -- vim.api.nvim_win_set_option(win, "border", "single") -- Options: single, double, rounded, solid
      end,
    })
  end,
}
