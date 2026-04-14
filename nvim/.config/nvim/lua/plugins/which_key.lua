-- ================================================================================================
-- TITLE : which-key
-- ABOUT : WhichKey helps you remember your Neovim keymaps, by showing keybindings as you type.
-- LINKS :
--   > github : https://github.com/folke/which-key.nvim
-- ================================================================================================

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		delay = 500,
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
			rules = false,
		},
		win = {
			border = "rounded",
			padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
			title = true,
			title_pos = "center",
			zindex = 1000,
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		spec = {
			-- Group Names
			{ "<leader>b", group = "󰓩 Buffer", mode = { "n", "v" } },
			{ "<leader>w", group = " Window", mode = { "n", "v" } },
			{ "<leader>f", group = "🔍 Search (FZF)", mode = { "n", "v" } },
			{ "<leader>e", group = "󰙅 Explorer", mode = { "n", "v" } },
			{ "<leader>c", group = "Code", icon = "󰅨", mode = { "n", "v" } },
			{ "<leader>x", group = "󱖫 Trouble", mode = { "n", "v" } }, -- The new 't' group
			{ "<leader>d", group = "󰃤 Debug (DAP)" },
			{ "<leader>h", group = "󰊢 Git", mode = { "n", "v" } },
		},
	},

	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Keymaps which-key",
		},
	},
}
