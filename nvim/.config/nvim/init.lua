vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

_G.Icons = {
  diagnostics = {
    Error = 'E',
    Warn  = 'W',
    Hint  = 'H',
    Info  = 'I',
  },

  git = {
    add          = ' ',
    change       = ' ',
    delete       = ' ',
    topdelete    = '󱅁 ',
    changedelete = '󱅃 ',
    untracked    = ' ',
    ignored      = 'ⓘ ',
    renamed      = 'Ⓡ ',
    conflict     = 'ⓧ ',
  }
}

require('options')
require('plugins.pack')
require('plugins.treesitter')
require('plugins.gruvbox')
require('plugins.snacks')
require('plugins.opencode_cfg')
require('plugins.mini')
require('plugins.lualine')
require('plugins.blink_cmp')
require('plugins.fzf_lua')
require('plugins.oil_cfg')
require('plugins.neo_tree')
require('plugins.neoscroll')
require('plugins.codediff')
require('plugins.render_markdown')
require('plugins.dap_cfg')
require('plugins.lsp')
require('autocommands')
require('keymaps')
require('plugins.mini_clue')
