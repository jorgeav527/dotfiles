-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)
vim.keymap.set('i', '<C-s>', '<Esc><cmd>w<CR>a', opts)

-- save file without auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)
vim.keymap.set('v', 'd', '"_d', opts)
vim.keymap.set('v', 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-Down>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-Up>', '<C-u>zz', opts)

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>bx', ':bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>bn', '<cmd> enew <CR>', opts) -- new buffer

-- Navigate between splits
vim.keymap.set('n', '<C-Left>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':wincmd l<CR>', opts)

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- “select all”, and mapping it to Ctrl+a
vim.keymap.set('n', '<C-a>', 'ggVG', opts)
vim.keymap.set('i', '<C-a>', '<Esc>ggVG', opts)
vim.keymap.set('v', '<C-a>', 'ggVG', opts)

-- Once everything is highlighted, you can clear it with
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>')
