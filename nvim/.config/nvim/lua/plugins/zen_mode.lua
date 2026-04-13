-- TITLE : zen-mode
-- ABOUT : Distraction-free coding for Neovim
return {
	"folke/zen-mode.nvim",
	dependencies = {
		"folke/twilight.nvim",
	},

	keys = {
		{
			"<leader>z",
			function()
				-- 1. Close Neo-tree if it's open before entering Zen
				-- We use pcall to avoid errors if neo-tree isn't installed
				pcall(function()
					require("neo-tree.command").execute({ action = "close" })
				end)

				-- 2. Toggle Zen Mode
				require("zen-mode").toggle()
			end,
			desc = "Zen Mode",
		},
	},

	opts = {
		window = {
			backdrop = 1,
			width = 0.60,
		},

		plugins = {
			options = { enabled = true, ruler = false, showcmd = false },
			tmux = { enabled = false },
			kitty = { enabled = false, font = "+2" },
		},

		on_open = function()
			pcall(function()
				require("twilight").enable()
			end)
		end,

		on_close = function()
			pcall(function()
				require("twilight").disable()
			end)
		end,
	},
}
