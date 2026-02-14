-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'general save file' })
vim.keymap.set('i', '<C-s>', '<Esc><cmd>w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<C-c>', '<cmd>%y+<CR>', { desc = 'general copy whole file' })

-- Quit
vim.keymap.set('n', '<C-q>', '<cmd>q<CR>', { desc = 'Quit current window' })

-- Black Hole Deletion (No yanking)
vim.keymap.set('n', 'x', '"_x', { desc = 'Delete char (no yank)' })
vim.keymap.set('v', 'd', '"_d', { desc = 'Delete selection (no yank)' })
vim.keymap.set('v', 'x', '"_x', { desc = 'Delete selection (no yank)' })
-- Sticky Paste (Keep clipboard content)
vim.keymap.set('v', 'p', '"_dP', { desc = 'Paste (keep clipboard)' })

-- Vertical scroll and center cursor
vim.keymap.set('n', '<C-Down>', '<C-d>zz', { desc = 'Scroll down & center' })
vim.keymap.set('n', '<C-Up>', '<C-u>zz', { desc = 'Scroll up & center' })

-- Navigate between splits
vim.keymap.set('n', '<C-Left>', ':wincmd h<CR>', { desc = 'Go to left window' })
vim.keymap.set('n', '<C-Right>', ':wincmd l<CR>', { desc = 'Go to right window' })

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', { desc = 'Toggle line wrap' })

-- Cycle through buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { desc = 'Previous buffer' })

-- Buffer actions
vim.keymap.set('n', '<leader>bx', ':bdelete!<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>bn', '<cmd>enew<CR>', { desc = 'New empty buffer' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>d[', function()
    vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

vim.keymap.set('n', '<leader>d]', function()
    vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>dd', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Once everything is highlighted, you can clear it with
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>')

-- comment lines
vim.keymap.set('n', '<leader>/', 'gcc', { desc = 'toggle comment', remap = true })
vim.keymap.set('v', '<leader>/', 'gc', { desc = 'toggle comment', remap = true })
