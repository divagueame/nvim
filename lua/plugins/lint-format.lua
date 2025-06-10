return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- lint.linters_by_ft = {
		--   javascript = { "eslint_d" },
		--   typescript = { "eslint_d" },
		--   javascriptreact = { "eslint_d" },
		--   typescriptreact = { "eslint_d" },
		--   python = { "pylint" },
		-- }

		lint.linters_by_ft = {
			javascript = function()
				local linter = vim.fn.filereadable(".eslintrc") == 1 and "eslint_d" or "biome"
				print("Using linter for JavaScript:", linter) -- Debug print
				return { linter }
			end,
			typescript = function()
				local linter = vim.fn.filereadable(".eslintrc") == 1 and "eslint_d" or "biome"
				print("Using linter for TypeScript:", linter) -- Debug print
				return { linter }
			end,
			javascriptreact = function()
				local linter = vim.fn.filereadable(".eslintrc") == 1 and "eslint_d" or "biome"
				print("Using linter for JavaScriptReact:", linter) -- Debug print
				return { linter }
			end,
			typescriptreact = function()
				local linter = vim.fn.filereadable(".eslintrc") == 1 and "eslint_d" or "biome"
				print("Using linter for TypeScriptReact:", linter) -- Debug print
				return { linter }
			end,
			python = { "pylint" },
		}

		vim.keymap.set("n", "<space><space>b", function()
			local file = vim.fn.expand("%") -- Get the current file path
			print("Fixing with biome: " .. file)
			local command = "biome format " .. file .. " --write"
			vim.fn.system(command)
			vim.cmd("silent! edit!") -- Reload the file after formatting
			print("Biome fixes applied to " .. file)
		end, { desc = "Fix current file with Biome" })
	end,
}
