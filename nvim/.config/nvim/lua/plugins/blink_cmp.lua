local cmp = require("blink.cmp")
cmp.build()
cmp.setup({
	keymap = {
		["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-u>"] = { "scroll_documentation_up", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	cmdline = {
		keymap = {
			["<CR>"] = { "accept_and_enter", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-s>"] = { "show", "fallback" },
		},
	},
	completion = {
		list = { selection = { preselect = false } },
		menu = { border = "single" },
		documentation = { window = { border = "single" } },
	},
	signature = { window = { border = "single" } },
})
