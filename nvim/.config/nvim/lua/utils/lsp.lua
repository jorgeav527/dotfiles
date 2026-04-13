local M = {}

M.on_attach = function(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if not client then
		return
	end
	local bufnr = event.buf
	local keymap = vim.keymap.set
	local opts = {
		noremap = true, -- prevent recursive mapping
		silent = true, -- don't print the command to the cli
		buffer = bufnr, -- restrict the keymap to the local buffer number
	}

	-- native neovim keymaps
	keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition", buffer = bufnr })
	keymap("n", "gD", "<cmd>Lspsaga goto_definition<CR>", { desc = "Goto Definition", buffer = bufnr })
	keymap("n", "<leader>ls", "<cmd>vsplit | Lspsaga goto_definition<CR>", { desc = "Goto Definition (Split)", buffer = bufnr })
	keymap("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action", buffer = bufnr })
	keymap("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", { desc = "Rename Symbol", buffer = bufnr })
	keymap("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Line Diagnostics", buffer = bufnr })
	keymap("n", "<leader>lD", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { desc = "Cursor Diagnostics", buffer = bufnr })
	keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev Diagnostic", buffer = bufnr })
	keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic", buffer = bufnr })
	keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover Documentation", buffer = bufnr })

	-- fzf-lua keymaps (LSP)
	keymap("n", "<leader>lf", "<cmd>FzfLua lsp_finder<CR>", { desc = "LSP Finder", buffer = bufnr })
	keymap("n", "<leader>lR", "<cmd>FzfLua lsp_references<CR>", { desc = "Show References", buffer = bufnr })
	keymap("n", "<leader>lt", "<cmd>FzfLua lsp_typedefs<CR>", { desc = "Type Definitions", buffer = bufnr })
	keymap("n", "<leader>lS", "<cmd>FzfLua lsp_document_symbols<CR>", { desc = "Document Symbols", buffer = bufnr })
	keymap("n", "<leader>lw", "<cmd>FzfLua lsp_workspace_symbols<CR>", { desc = "Workspace Symbols", buffer = bufnr })
	keymap("n", "<leader>li", "<cmd>FzfLua lsp_implementations<CR>", { desc = "Implementations", buffer = bufnr })

	-- Order Imports (if supported by the client LSP)
	if client:supports_method("textDocument/codeAction", bufnr) then
		keymap("n", "<leader>lo", function()
			vim.lsp.buf.code_action({
				context = {
					only = { "source.organizeImports" },
					diagnostics = {},
				},
				apply = true,
				bufnr = bufnr,
			})
			-- format after changing import order
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50) -- slight delay to allow for the import order to go first
		end, { desc = "Organize Imports", buffer = bufnr })
	end

	-- === DAP keymaps ===
	if client.name == "rust-analyzer" then -- debugging only configured for Rust
		local dap = require("dap")
		keymap("n", "<leader>dc", dap.continue, { desc = "DAP Continue", buffer = bufnr })
		keymap("n", "<leader>do", dap.step_over, { desc = "DAP Step Over", buffer = bufnr })
		keymap("n", "<leader>di", dap.step_into, { desc = "DAP Step Into", buffer = bufnr })
		keymap("n", "<leader>du", dap.step_out, { desc = "DAP Step Out", buffer = bufnr })
		keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint", buffer = bufnr })
		keymap("n", "<leader>dr", dap.repl.open, { desc = "DAP REPL Open", buffer = bufnr })
	end
end

return M
