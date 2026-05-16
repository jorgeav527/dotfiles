require('blink.cmp').setup({
  keymap = {
    preset = 'default',
    ['<C-e>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-k>'] = { 'show_signature', 'hide_signature' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
  },
})
