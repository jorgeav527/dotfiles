-- lua/plugins/trouble.lua
return {
	"folke/trouble.nvim",
	opts = {},
	cmd = "Trouble",
	lazy = true,
	keys = {
		{
			"<leader>xw",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "󱖫 Workspace Diagnostics (Trouble)",
		},
		{
			"<leader>xb",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "󱖫 Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>xs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "󱖫 Symbols List (Trouble)",
		},
		{
			"<leader>xr",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "󱖫 Definitions/References (Trouble)",
		},
		{
			"<leader>xl",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "󱖫 Location List (Trouble)",
		},
		{
			"<leader>xq",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "󱖫 Quickfix List (Trouble)",
		},
	},
}
