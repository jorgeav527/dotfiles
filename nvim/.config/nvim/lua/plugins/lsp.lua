vim.lsp.config("vtsls", {
	filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					{
						name = "@vue/typescript-plugin",
						location = "/home/jorgeav527/.nvm/versions/node/v24.11.1/lib/node_modules/@vue/language-server",
						languages = { "vue" },
						configNamespace = "typescript",
						enableForWorkspaceTypeScriptVersions = true,
					},
				},
			},
		},
	},
})

vim.lsp.enable({
	"lua_ls",
	"html",
	"cssls",
	"vtsls",
	"vue_ls",
	"tailwindcss",
	"terraformls",
	"tflint",
	"ruff",
	"ty",
})
