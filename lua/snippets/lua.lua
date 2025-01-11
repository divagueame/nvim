local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	-- -- Function snippet
	-- s("fn", fmt(
	--   [[
	--   functionmeow {}({})
	--     {}
	--   end
	--   ]],
	--   {
	--     i(1, "name"),
	--     i(2, "args"),
	--     i(3, "-- TODO: implement")
	--   }
	-- )),
	--
	-- -- Require snippet
	-- s("req", fmt(
	--   [[local {} = require("{}")]]
	--   ,
	--   {
	--     f(function(import_name)
	--       local parts = vim.split(import_name[1][1], ".", true)
	--       return parts[#parts] or ""
	--     end, {1}),
	--     i(1, "module_name")
	--   }
	-- )),
	--
	-- -- For loop snippet
	-- s("for", fmt(
	--   [[
	--   for {} = {}, {} do
	--     {}
	--   end
	--   ]],
	--   {
	--     i(1, "i"),
	--     i(2, "1"),
	--     i(3, "10"),
	--     i(4, "-- TODO: implement")
	--   }
	-- )),
	--
	-- -- If statement snippet
	-- s("if", fmt(
	--   [[
	--   if {} then
	--     {}
	--   end
	--   ]],
	--   {
	--     i(1, "condition"),
	--     i(2, "-- TODO: implement")
	--   }
	-- )),
	--
	-- -- Neovim plugin spec snippet
	-- s("plug", fmt(
	--   [[
	--   {{
	--     "{}",
	--     {}
	--     config = function()
	--       {}
	--     end,
	--   }},
	--   ]],
	--   {
	--     i(1, "author/plugin-name"),
	--     c(2, {
	--       t(""),
	--       fmt([[dependencies = {{ "{}" }},]], { i(1, "dependency") }),
	--       t('event = "VeryLazy",'),
	--       t('cmd = "",'),
	--     }),
	--     i(3, "-- TODO: configure plugin")
	--   }
	-- )),
}
