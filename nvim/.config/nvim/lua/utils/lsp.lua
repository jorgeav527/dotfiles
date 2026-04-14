local M = {}

M.on_attach = function(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if not client then
		return
	end
	local bufnr = event.buf

	local function map(mode, lhs, rhs, opts)
		if type(opts) == "string" then
			opts = { desc = opts }
		end
		opts = opts or {}
		opts.buffer = bufnr
		opts.silent = opts.silent ~= false
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	local fzf = require("fzf-lua")

	-- LSP Navigation (using fzf-lua)
	map("n", "gd", fzf.lsp_definitions, "󰈔 Goto Definition")
	map("n", "gr", fzf.lsp_references, "󰬲 Goto References")
	map("n", "gI", fzf.lsp_implementations, "󰬄 Goto Implementation")
	map("n", "gD", vim.lsp.buf.declaration, "󰬀 Goto Declaration")
	map("n", "K", vim.lsp.buf.hover, "󱙼 Hover Documentation")
	map("n", "gs", fzf.lsp_document_symbols, "Document Symbols")
	map("n", "gS", fzf.lsp_live_workspace_symbols, "Workspace Symbols")
	map("n", "gJ", fzf.lsp_typedefs, "Type Definition")

	-- Code Actions & Rename (under <leader>c)
	map("n", "<leader>cr", vim.lsp.buf.rename, "󰑕 Rename Symbol")
	map("n", "<leader>ca", vim.lsp.buf.code_action, "󰅨 Code Action")
	map("n", "<leader>cd", vim.diagnostic.open_float, "󰈻 Line Diagnostics")

	-- Diagnostics Navigation (Native)
	map("n", "[d", function()
		vim.diagnostic.jump({ count = -1, float = true })
	end, "Prev Diagnostic")
	map("n", "]d", function()
		vim.diagnostic.jump({ count = 1, float = true })
	end, "Next Diagnostic")

	-- Order Imports (if supported by the client LSP)
	if client:supports_method("textDocument/codeAction", bufnr) then
		map("n", "<leader>co", function()
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
		end, "Organize Imports")
	end

	-- === DAP keymaps ===
	if client.name == "rust-analyzer" then -- debugging only configured for Rust
		local dap = require("dap")
		map("n", "<leader>dc", dap.continue, "DAP Continue")
		map("n", "<leader>do", dap.step_over, "DAP Step Over")
		map("n", "<leader>di", dap.step_into, "DAP Step Into")
		map("n", "<leader>du", dap.step_out, "DAP Step Out")
		map("n", "<leader>db", dap.toggle_breakpoint, "DAP Toggle Breakpoint")
		map("n", "<leader>dr", dap.repl.open, "DAP REPL Open")
	end
end

return M
