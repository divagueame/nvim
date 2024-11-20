return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()

    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      python = { "pylint" },
      -- markdown = { 'markdownlint' },
    }

    -- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    -- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    --   group = lint_augroup,
    --   callback = function()
    --     lint.try_lint()
    --   end,
    -- })

    -- vim.keymap.set("n", "<tab>l", function()
      -- lint.try_lint()
      --
      -- print('Linting....')
      -- local file = vim.fn.expand('%')  -- Get the current file path
      -- local command = "npx eslint " .. file .. " --fix"
      -- vim.fn.system(command)
      -- print('Linting complete for ' .. file)

    -- end, { desc = "Trigger linting for current file" })
  end,
}
