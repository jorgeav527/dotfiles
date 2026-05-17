local cmp = require('blink.cmp')
cmp.build()
cmp.setup({
  keymap = {
    preset = 'super-tab',
    ['<C-s>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
  },
  completion = {
    menu = { border = 'single' },
    documentation = { window = { border = 'single' } },
  },
  signature = { window = { border = 'single' } },
})
