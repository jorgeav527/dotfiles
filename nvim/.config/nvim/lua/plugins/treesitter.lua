vim.cmd('syntax off')

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    if not pcall(vim.treesitter.start) then
      vim.cmd('syntax on')
    end
  end,
})
