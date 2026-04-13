--   > github : https://github.com/echasnovski/mini.nvim
-- ABOUT : Library of 40+ independent Lua modules.

return {
	{ "echasnovski/mini.ai", version = "*", opts = {} },

	-- Fixed mini.comment
	{
		"echasnovski/mini.comment",
		version = "*",
		opts = {
			options = {
				custom_commentstring = nil,
				ignore_blank_line = true,
				start_of_line = false,
				pad_comment_parts = true,
			},
			mappings = {
				comment = "gc",
				comment_line = "gcc",
				comment_visual = "gc",
				textobject = "gc",
			},
		},
	},

	-- Fixed mini.move
	{
		"echasnovski/mini.move",
		version = "*",
		opts = {
			reindent_linewise = true,
			mappings = {
				-- Move visual selection
				left = "<A-Left>",
				right = "<A-Right>",
				down = "<A-Down>",
				up = "<A-Up>",

				-- Move current line
				line_left = "<A-Left>",
				line_right = "<A-Right>",
				line_down = "<A-Down>",
				line_up = "<A-Up>",
			},
		},
	},

	{ "echasnovski/mini.surround", version = "*", opts = {} },
	{ "echasnovski/mini.cursorword", version = "*", opts = {} },
	{ "echasnovski/mini.indentscope", version = "*", opts = {} },
	{ "echasnovski/mini.pairs", version = "*", opts = {} },
	{ "echasnovski/mini.trailspace", version = "*", opts = {} },
	{ "echasnovski/mini.bufremove", version = "*", opts = {} },
	{ "echasnovski/mini.trailspace", version = "*", opts = {} },
}
