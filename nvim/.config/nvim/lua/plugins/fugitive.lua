-- ABOUT : A Git wrapper plugin for Vim and Neovim. Provides powerful Git integration and commands.
-- LINKS :
--   > github : https://github.com/tpope/vim-fugitive

return {
	"tpope/vim-fugitive",
	keys = {
		{ "<leader>hg", "<cmd>Git<cr>", desc = "󰊢 Git Status (Fugitive)" },
	},
}
