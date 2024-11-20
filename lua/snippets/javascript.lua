local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node

ls.add_snippets("vue", {
	s("pre", {
		f(function()
			local yanked_content = vim.fn.getreg('"')
			return "<pre>{{" .. yanked_content .. "}}</pre>"
		end),
	}),
})
