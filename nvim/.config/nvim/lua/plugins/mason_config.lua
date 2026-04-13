return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason", -- Only load when we use the Mason command
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			-- Automatically install these LSPs
			ensure_installed = {
				"efm",
				"lua_ls",
				"ty",
				"emmet_ls",
				"gopls",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			-- Automatically install these Linters/Formatters
			ensure_installed = {
				"luacheck",
				"stylua",
				"ruff",
				"prettierd",
				"eslint_d",
				"fixjson",
				"revive",
				"gofumpt",
				"goimports",
				"shellcheck",
				"shfmt",
				"hadolint",
			},
		},
	},
}
