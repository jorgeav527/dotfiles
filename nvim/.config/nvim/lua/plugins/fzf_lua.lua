-- LINKS :
--    > github : https://github.com/ibhagwan/fzf-lua
-- ABOUT : lua-based fzf wrapper and integration.

return {
	"ibhagwan/fzf-lua",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		-- File & Search
		{ "<leader>ff", "<cmd>FzfLua files<CR>", desc = "🔍 Find Files" },
		{ "<leader>fg", "<cmd>FzfLua live_grep<CR>", desc = "󰈬 Live Grep" },
		{ "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "󰓩 Find Buffers" },
		{ "<leader>f?", "<cmd>FzfLua help_tags<CR>", desc = "󰋖 Help Tags" },
		{ "<leader>f/", "<cmd>FzfLua blines<CR>", desc = "🔍 Fuzzy Search in Buffer" },

		-- Diagnostics
		{ "<leader>fd", "<cmd>FzfLua diagnostics_document<CR>", desc = "󰈻 Diagnostics (Buffer)" },
		{ "<leader>fD", "<cmd>FzfLua diagnostics_workspace<CR>", desc = "󰈻 Diagnostics (Workspace)" },

		-- LSP Related (Consolidated under <leader>f)
		{ "<leader>fR", "<cmd>FzfLua lsp_finder<CR>", desc = "󰈻 LSP Finder" },
		{ "<leader>fr", "<cmd>FzfLua lsp_references<CR>", desc = "󰈻 Show References" },
		{ "<leader>ft", "<cmd>FzfLua lsp_typedefs<CR>", desc = "󰈻 Type Definitions" },
		{ "<leader>fi", "<cmd>FzfLua lsp_implementations<CR>", desc = "󰈻 Implementations" },
		{ "<leader>fs", "<cmd>FzfLua lsp_document_symbols<CR>", desc = "󰈻 Document Symbols" },
		{ "<leader>fS", "<cmd>FzfLua lsp_workspace_symbols<CR>", desc = "󰈻 Workspace Symbols" },
	},
	opts = {},
}
