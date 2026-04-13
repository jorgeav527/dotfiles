-- TITLE : trouble.nvim
-- ABOUT : A pretty diagnostics, references, quickfix and location list viewer for Neovim.
-- LINKS :
--   > github : https://github.com/folke/trouble.nvim

return {
	"folke/trouble.nvim",
	opts = {}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	lazy = true,
	keys = {
		{
			"<leader>lxx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "󱖫 Workspace Diagnostics (Trouble)",
		},
		{
			"<leader>lxb",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "󱖫 Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>lss",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "󱖫 Symbols List (Trouble)",
		},
		{
			"<leader>ll",
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
