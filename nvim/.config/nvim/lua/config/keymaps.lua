-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local MAP = vim.keymap.set

MAP("n", "<A-PageUp>", "<cmd>bprevious<CR>", { desc = "Previous Buffer" })
MAP("n", "<A-PageDown>", "<cmd>bnext<CR>", { desc = "Next Buffer" })

-- ~/.config/nvim/lua/config/keymaps.lua
MAP("n", "<C-a>", "ggVG", { desc = "Select all" })

MAP("n", "<C-Down>", "<Cmd>execute 'move .+' . v:count1<CR>==", { desc = "Move Down" })
MAP("n", "<C-Up>", "<Cmd>execute 'move .-' . (v:count1 + 1)<CR>==", { desc = "Move Up" })
MAP("i", "<C-Down>", "<esc><Cmd>m .+1<CR>==gi", { desc = "Move Down" })
MAP("i", "<C-Up>", "<esc><Cmd>m .-2<CR>==gi", { desc = "Move Up" })
MAP("x", "<C-Down>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv", { desc = "Move Down" })
MAP("x", "<C-Up>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv", { desc = "Move Up" })

MAP({ "n", "x" }, "x", '"_x', { desc = "Delete Chars Into Void" })
MAP({ "n", "x" }, "X", '"_x', { desc = "Delete Chars Into Void" })
MAP({ "n", "x" }, "<Del>", '"_x', { desc = "Delete Chars Into Void" })

MAP("x", "y", "ygv<Esc>", { desc = "Yank Preserve Cursor" })
MAP("x", "p", "P", { desc = "Paste Without Override" })

MAP("n", "<leader>bc", ":let @+ = expand('%:.')<CR>", { desc = "Copy Path" })
