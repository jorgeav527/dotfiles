-- ================================================================================================
-- TITLE : auto-commands
-- ABOUT : automatically run code on defined events (e.g. save, yank)
-- ================================================================================================
local on_attach = require("utils.lsp").on_attach

-- Restore last cursor position when reopening a file
local last_cursor_group = vim.api.nvim_create_augroup("LastCursorGroup", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
	group = last_cursor_group,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Highlight the yanked text
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 100,
		})
	end,
})

-- Consolidated Format on Save
-- Handles whitespace trimming and synchronous LSP formatting (EFM/Native)
local format_augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = format_augroup,
	callback = function()
		-- 1. Trim trailing whitespace
		local status_ok, mini_trail = pcall(require, "mini.trailspace")
		if status_ok then
			mini_trail.trim()
		end

		-- 2. Format via LSP (synchronous so it finishes before write)
		-- This will use EFM if configured, or your language's native LSP formatter.
		vim.lsp.buf.format({ async = false })
	end,
})

-- On attach function shortcuts
local lsp_on_attach_group = vim.api.nvim_create_augroup("LspMappings", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_on_attach_group,
	callback = on_attach,
})

-- Custom options for text/markdown files
local markdown_options = vim.api.nvim_create_augroup("MarkdownOptions", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = markdown_options,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
		vim.opt_local.cursorline = false
		vim.opt_local.colorcolumn = ""
		vim.opt_local.signcolumn = "no"
	end,
})

-- Custom options to detect Helm YAML
local helm_group = vim.api.nvim_create_augroup("HelmDetect", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	group = helm_group,
	pattern = { "*.yaml", "*.yml" },
	callback = function()
		if vim.fn.getline(1):match("^apiVersion:") or vim.fn.getline(2):match("^apiVersion:") then
			vim.opt_local.filetype = "helm"
		end
	end,
})

-- Disable auto-commenting on new lines
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
	desc = "Stop Neovim from automatically starting a new comment line",
})
