local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node

-- ls.add_snippets("javascript", {
--   s("pre", {
--     -- Insert a new line and <pre>...</pre> around the yanked content
--     f(function()
--       local yanked_content = vim.fn.getreg('"')  -- Get the content of the unnamed register
--       return "<pre>{{" .. yanked_content .. "}}</pre>"
--     end),
--   }),
-- })

ls.add_snippets("vue", {
  s("pre", {
    f(function()
      local yanked_content = vim.fn.getreg('"')
      return "<pre>{{" .. yanked_content .. "}}</pre>"
    end),
  }),
})


