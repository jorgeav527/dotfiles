require('mini.icons').setup()
require('mini.icons').mock_nvim_web_devicons()
require('mini.move').setup({
  mappings = {
    left       = '<A-Left>',
    right      = '<A-Right>',
    down       = '<A-Down>',
    up         = '<A-Up>',
    line_left  = '<A-Left>',
    line_right = '<A-Right>',
    line_down  = '<A-Down>',
    line_up    = '<A-Up>',
  },
  options = {
    reindent_linewise = true,
  },
})
require('mini.pairs').setup({})
require('mini.trailspace').setup({})
require('mini.surround').setup({})
require('mini.splitjoin').setup({
  mappings = {
    toggle = '<leader>cs',
  },
})
require('mini.indentscope').setup({})
require('mini.diff').setup({
  view = {
    style = 'sign',
    signs = Icons.git,
  },
  mappings = {
    apply      = '<leader>hs',
    reset      = '<leader>hr',
    goto_first = '[H',
    goto_prev  = '[h',
    goto_next  = ']h',
    goto_last  = ']H',
  },
})
local hipatterns = require('mini.hipatterns')
hipatterns.setup({
  highlighters = {
    fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
    todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
    note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})
