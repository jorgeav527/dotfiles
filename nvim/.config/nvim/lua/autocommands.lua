local last_cursor_group = vim.api.nvim_create_augroup('LastCursorGroup', {})
vim.api.nvim_create_autocmd('BufReadPost', {
  group = last_cursor_group,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
  end,
  desc = 'Stop Neovim from automatically starting a new comment line',
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    local bufnr = ev.buf
    local filetype = vim.bo[bufnr].filetype

    if filetype == 'lua' then
      if client.name == 'lua_ls' and client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('LspFormatLua.' .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 }) end,
        })
      end
    end

    if filetype == 'python' then
      if client.name == 'ruff' and client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('LspFormatPython.' .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports.ruff' } }, apply = true })
            vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
            vim.api.nvim_echo({ { 'Ruff: Imports sorted & Formatted', 'None' } }, false, {})
          end,
        })
      end
    end

    if filetype == 'html' or filetype == 'css' then
      if (client.name == 'html' or client.name == 'cssls') and client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('LspFormatWeb.' .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 }) end,
        })
      end
    end

    if filetype == 'javascript' or filetype == 'typescript' then
      if client.name == 'vtsls' and client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('LspFormatJS.' .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.execute_command({ command = 'typescript.organizeImports', arguments = { vim.api.nvim_buf_get_name(bufnr) } })
            vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
          end,
        })
      end
    end

    if filetype == 'json' or filetype == 'jsonc' then
      if client.name == 'jsonls' and client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('LspFormatJson.' .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 }) end,
        })
      end
    end

    if filetype == 'terraform' or filetype == 'terraform-vars' then
      if client.name == 'terraformls' and client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('LspFormatTerraform.' .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
          end,
        })
      end
    end

    if filetype == 'dockerfile' then
      if client.name == 'dockerls' and client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('LspFormatDocker.' .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 }) end,
        })
      end
    end

    if filetype == 'yaml' then
      if client.name == 'yamlls' and client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('LspFormatYaml.' .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
          end,
        })
      end
    end

    if filetype == 'vue' then
      if client.name == 'vue_ls' and client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('LspFormatVue.' .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 }) end,
        })
      end
    end
  end,
})
