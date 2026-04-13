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
			{ "<leader>g", group = "󰊢 Git", mode = { "n", "v" } },
			{ "<leader>gt", group = "󰊢 Git Toggles", mode = { "n", "v" } },
			{ "<leader>l", group = "🅻 LSP", mode = { "n", "v" } },
			{ "<leader>la", group = "🅻 Code Action", mode = { "n", "v" } },
			{ "<leader>ld", group = "🅻 Diagnostics", mode = { "n", "v" } },
			{ "<leader>lx", group = "󱖫 Trouble", mode = { "n", "v" } },
			{ "<leader>d", group = "󰃤 Debug (DAP)", mode = { "n", "v" } },
			{ "<leader>h", group = "󰊢 Git Hunks", mode = { "n", "v" } }, -- For backward compatibility if needed, but we used <leader>gs
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
