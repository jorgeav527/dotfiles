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

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.git' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = { enable = false },
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

local formats = {
  lua                = { 'lua_ls' },
  python             = {
    'ruff',
    pre = function()
      vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports.ruff' } }, apply = true })
      vim.api.nvim_echo({ { 'Ruff: Imports sorted & Formatted', 'None' } }, false, {})
    end
  },
  html               = { 'html', 'cssls' },
  css                = { 'html', 'cssls' },
  javascript         = {
    'vtsls',
    pre = function(bufnr)
      vim.lsp.buf.execute_command({ command = 'typescript.organizeImports', arguments = { vim.api.nvim_buf_get_name(bufnr) } })
    end
  },
  typescript         = {
    'vtsls',
    pre = function(bufnr)
      vim.lsp.buf.execute_command({ command = 'typescript.organizeImports', arguments = { vim.api.nvim_buf_get_name(bufnr) } })
    end
  },
  json               = { 'jsonls' },
  jsonc              = { 'jsonls' },
  terraform          = { 'terraformls' },
  ['terraform-vars'] = { 'terraformls' },
  dockerfile         = { 'dockerls' },
  yaml               = { 'yamlls' },
  vue                = { 'vue_ls' },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    local bufnr = ev.buf
    local filetype = vim.bo[bufnr].filetype
    local entry = formats[filetype]

    if entry then
      local match = client.name == entry[1] or vim.tbl_contains(entry, client.name)
      if match and client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('LspFormat.' .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function()
            if entry.pre then entry.pre(client.id, bufnr) end
            vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
          end,
        })
      end
    end
  end,
})
