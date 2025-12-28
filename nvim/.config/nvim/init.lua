require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps
require 'core.autocmds' -- Custom code autocmds

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Import color theme based on environment variable NVIM_THEME
local color_scheme = 'tokyonight'

-- Define a table of theme modules
local themes = {
    nord = 'plugins.themes.nord',
    tokyonight = 'plugins.themes.tokyonight',
}
-- Set up plugin
require('lazy').setup {
    require 'plugins.neotree',
    require(themes[color_scheme]),
    -- require 'plugins.colortheme',
    require 'plugins.lualine',
    require 'plugins.treesitter',
    require 'plugins.telescope',
    require 'plugins.lsp',
    require 'plugins.autocompletion',
    require 'plugins.autoformatting',
    require 'plugins.gitsigns',
    require 'plugins.indentline',
    require 'plugins.any',
    require 'plugins.lazygit',
    require 'plugins.spectre',
    require 'plugins.splitjoin',
    require 'plugins.mini.comment',
    require 'plugins.mini.move',
    require 'plugins.mini.pairs',
    require 'plugins.mini.surround',
}
