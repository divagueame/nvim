local colemak = {}

local mappings = {
	-- Up/down/left/right
	{ modes = { "n", "o", "x" }, lhs = "n", rhs = "h", desc = "Left (h)" },
	{ modes = { "n", "o", "x" }, lhs = "u", rhs = "k", desc = "Up (k)" },
	{ modes = { "n", "o", "x" }, lhs = "e", rhs = "j", desc = "Down (j)" },
	{ modes = { "n", "o", "x" }, lhs = "i", rhs = "l", desc = "Right (l)" },

	-- Beginning/end of line
	{ modes = { "n", "o", "x" }, lhs = "L", rhs = "^", desc = "First non-blank character" },
	{ modes = { "n", "o", "x" }, lhs = "Y", rhs = "$", desc = "End of line" },

	-- PageUp/PageDown
	{ modes = { "n", "x" }, lhs = "j", rhs = "<PageUp>", desc = "DESC" },
	{ modes = { "n", "x" }, lhs = "h", rhs = "<PageDown>", desc = "DESC" },

	-- Jumplist navigation
	{ modes = { "n" }, lhs = "<C-u>", rhs = "<C-i>", desc = "Jumplist forward" },
	{ modes = { "n" }, lhs = "<C-e>", rhs = "<C-o>", desc = "Jumplist forward" },

		(		-- Word left/right
{ modes = { "n", "o", "x" }, lhs = "l", rhs = "b", desc = "Word back" }),
	{ modes = { "n", "o", "x" }, lhs = "y", rhs = "w", desc = "Word forward" },
	{ modes = { "n", "o", "v" }, lhs = "<C-l>", rhs = "B", desc = "WORD back" },
	{ modes = { "n", "o", "v" }, lhs = "<C-y>", rhs = "W", desc = "WORD forward" },

	-- End of word left/right
	{ modes = { "n", "o", "x" }, lhs = "N", rhs = "ge", desc = "End of word back" },
	{ modes = { "n", "o", "x" }, lhs = "<M-n>", rhs = "gE", desc = "End of WORD back" },
	{ modes = { "n", "o", "x" }, lhs = "I", rhs = "e", desc = "End of word forward" },
	{ modes = { "n", "o", "x" }, lhs = "<M-i>", rhs = "E", desc = "End of WORD forward" },

	-- Text objects
	-- diw is drw. daw is now dtw.
	{ modes = { "o", "v" }, lhs = "r", rhs = "i", desc = "O/V mode: inner (i)" },
	{ modes = { "o", "v" }, lhs = "t", rhs = "a", desc = "O/V mode: a/an (a)" },
	-- Move visual replace from 'r' to 'R'
	{ modes = { "o", "v" }, lhs = "R", rhs = "r", desc = "Replace" },

	-- Folds
	{ modes = { "n", "x" }, lhs = "b", rhs = "z" },
	{ modes = { "n", "x" }, lhs = "bb", rhs = "zb", desc = "Scroll line and cursor to bottom" },
