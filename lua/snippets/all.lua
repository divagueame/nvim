-- -- local ls = require("luasnip")
-- -- local s = ls.snippet
-- -- local t = ls.text_node
-- -- local i = ls.insert_node
--
-- local snippet = require("luasnip").snippet
--
-- return {
--   -- A snippet that expands the trigger "hi" into the string "Hello, world!".
--   snippet(
--     { trig = "cl" },
--     {
--       "consolmeowe.log(", -- Start of the snippet
--       -- "\t$0", -- Placeholder for cursor placement
--       -- ")", -- End of the snippet
--     }
--     -- { t("console.log({<>})") }
--   ),
--   -- snippet(
--     -- { trig = "chi" },
--     -- { "Another snippet." }
--   -- ),
-- }
--
--
--
--
-- Place this in ${HOME}/.config/nvim/LuaSnip/all.lua
-- hiwaw
return {
  -- A snippet that expands the trigger "hi" into the string "Hello, world!".
  require("luasnip").snippet(
    { trig = "hiwaw" },
    { t("Hello, world!") }
  ),

  -- To return multiple snippets, use one `return` statement per snippet file
  -- and return a table of Lua snippets.
  require("luasnip").snippet(
    { trig = "himeow" },
    { t("Another snippet.") }
  ),
}
