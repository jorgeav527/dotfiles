-- ================================================================================================
-- TITLE : fzf-lua
-- LINKS :
--   > github : https://github.com/ibhagwan/fzf-lua
-- ABOUT : lua-based fzf wrapper and integration.
-- ================================================================================================

return {
	"ibhagwan/fzf-lua",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "🔍 Find Files",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "󰈬 Live Grep",
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "󰓩 Find Buffers",
		},
		{
			"<leader>f?",
			function()
				require("fzf-lua").help_tags()
			end,
			desc = "󰋖 Help Tags",
		},
		{
			"<leader>fd",
			function()
				require("fzf-lua").diagnostics_document()
			end,
			desc = "󰈻 Diagnostics (Buffer)",
		},
		{
			"<leader>fD",
			function()
				require("fzf-lua").diagnostics_workspace()
			end,
			desc = "󰈻 Diagnostics (Workspace)",
		},
		{
			"<leader>fs",
			function()
				require("fzf-lua").lsp_document_symbols()
			end,
			desc = "󰈻 Document Symbols",
		},
		{
			"<leader>fw",
			function()
				require("fzf-lua").lsp_workspace_symbols()
			end,
			desc = "󰈻 Workspace Symbols",
		},
		{
			"<leader>f/",
			function()
				require("fzf-lua").blines()
			end,
			desc = "🔍 Fuzzy Search in Buffer",
		},
	},

	opts = {},
}
