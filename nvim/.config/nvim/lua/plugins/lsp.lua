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

vim.lsp.config('vtsls', {
  filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue' },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            location = '/home/jorgeav527/.nvm/versions/node/v24.11.1/lib/node_modules/@vue/language-server',
            languages = { 'vue' },
            configNamespace = 'typescript',
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
    },
  },
})

vim.lsp.enable({
  'ty', 'ruff', 'lua_ls', 'html', 'cssls', 'jsonls', 'vue_ls', 'vtsls', 'tailwindcss', 'terraformls', 'tflint',
  'dockerls', 'yamlls',
})

vim.lsp.config('cssls', {
  settings = {
    css = {
      lint = {
        unknownAtRules = 'ignore',
      },
    },
  },
})
