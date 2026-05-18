for name, icon in pairs(Icons.diagnostics) do
  local hl = 'DiagnosticSign' .. name
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = Icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN]  = Icons.diagnostics.Warn,
      [vim.diagnostic.severity.HINT]  = Icons.diagnostics.Hint,
      [vim.diagnostic.severity.INFO]  = Icons.diagnostics.Info,
    },
  },
  float = { source = 'if_many', border = 'rounded' },
})
