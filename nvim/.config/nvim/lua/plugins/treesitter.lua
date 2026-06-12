require("nvim-treesitter")
	.install({
		"vue",
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"json",
	})
	:wait(300000)

-- Register language aliases
vim.treesitter.language.register("html", { "html", "htmldjango", "xhtml" })
vim.treesitter.language.register("vue", { "vue" })
vim.treesitter.language.register("tsx", { "typescriptreact", "tsx" })
vim.treesitter.language.register("javascript", { "javascript", "js" })

-- Enable treesitter highlighting for filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "vue", "html", "css", "javascript", "typescript", "tsx", "json" },
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

-- Optional: Turn off syntax highlighting (treesitter replaces it)
vim.cmd("syntax off")
