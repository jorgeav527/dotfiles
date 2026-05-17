local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    { mode = 'n', keys = '<C-w>' },
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },
    { mode = 'n', keys = 's' },
    { mode = 'v', keys = 'a' },
    { mode = 'n', keys = '-' }
  },
  clues = {
    { mode = 'n', keys = '<leader>b',  desc = '+[b]uffers' },
    { mode = 'n', keys = '<leader>ba', desc = 'Copy Absolute Path' },
    { mode = 'n', keys = '<leader>br', desc = 'Copy Relative Path' },
    { mode = 'n', keys = '<leader>c',  desc = '+[c]ode' },
    { mode = 'n', keys = '<leader>cs', desc = 'split/Join toggle' },
    { mode = 'n', keys = '<leader>k',  desc = '+[K]Debug (DAP)' },
    { mode = 'n', keys = '<leader>d',  desc = '+[D]iagnostics/LSP' },
    { mode = 'n', keys = '<leader>h',  desc = '+[H]it (Git/Diff)' },
    { mode = 'n', keys = '<leader>f',  desc = '+[F]ind (Fzf)' },

    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
  window = { delay = 500, config = { border = 'double' } }
})
