-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- -------------------------
-- Cursorline Highlighting
-- -------------------------
local cursorline_group = vim.api.nvim_create_augroup("cursorline", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

vim.api.nvim_create_autocmd("WinLeave", {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- -------------------------
-- Makefile Settings
-- -------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "make" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
  end,
})

-- -------------------------
-- Detect Helm YAML
-- -------------------------
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.yaml", "*.yml" },
  callback = function()
    if vim.fn.getline(1):match("^apiVersion:") or vim.fn.getline(2):match("^apiVersion:") then
      vim.opt_local.filetype = "helm"
    end
  end,
})
