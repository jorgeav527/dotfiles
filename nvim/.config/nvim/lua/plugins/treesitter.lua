require("nvim-treesitter")
	.install({
		"vue",
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"json",
		"toml",
		"markdown",
		"markdown_inline",
		"query",
	})
	:wait(300000)

-- Register language aliases
vim.treesitter.language.register("html", { "html", "htmldjango", "xhtml" })
vim.treesitter.language.register("vue", { "vue" })
vim.treesitter.language.register("tsx", { "typescriptreact", "tsx" })
vim.treesitter.language.register("javascript", { "javascript", "js" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"vue",
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"json",
		"markdown",
	},
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

vim.cmd("syntax on")
