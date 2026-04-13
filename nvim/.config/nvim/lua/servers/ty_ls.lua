-- ================================================================================================
-- TITLE : pyright (Python Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/astral-sh/ty
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil This function doesn't return a value, it configures the LSP server
return function(capabilities)
	vim.lsp.config("ty", {
		capabilities = capabilities,
		settings = {
			ty = {
				logLevel = "info",
				analysis = {
					diagnosticMode = "openFilesOnly",
					typeCheckingMode = "standard", -- Can be "off", "standard", or "strict"
				},
			},
		},
	})
end
