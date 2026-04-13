-- Basic movement
vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- Files & Saving
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save file" })
vim.keymap.set({ "n", "i", "v" }, "<C-q>", "<Esc><cmd>wqall<CR>", { desc = "Save and Quit All" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save buffer" })
vim.keymap.set("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy whole file to system clipboard" })
vim.keymap.set({ "n", "i", "v" }, "<C-a>", "<Esc>ggVG", { desc = "Select all" })

-- Search & Navigation
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-Down>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-Up>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Deleting (no yank)
vim.keymap.set("n", "x", '"_x', { desc = "Delete char (no yank)" })
vim.keymap.set("v", "d", '"_d', { desc = "Delete selection (no yank)" })
vim.keymap.set("v", "x", '"_x', { desc = "Delete selection (no yank)" })
vim.keymap.set("v", "p", '"_dP', { desc = "Paste (no yank)" })

-- [B]uffer Management
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete!<CR>", { desc = "Delete current buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>enew<CR>", { desc = "Create new buffer" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Copy Paths
vim.keymap.set("n", "<leader>bpa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify("Copied absolute path: " .. path)
end, { desc = "Copy Absolute Path" })

vim.keymap.set("n", "<leader>bpr", function()
	local fullpath = vim.fn.expand("%:p")
	local cwd = vim.fn.getcwd()
	cwd = cwd:gsub("([%-%.%+%[%]%(%)%$%^%%%?%*])", "%%%1")
	local relative = fullpath:gsub("^" .. cwd .. "/", "")
	vim.fn.setreg("+", relative)
	vim.notify("Copied relative path: " .. relative)
end, { desc = "Copy Relative Path" })

-- [W]indow Management
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>wh", "<cmd>split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>wc", "<C-w>c", { desc = "Close current window" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Close other windows" })

-- Window Resizing
vim.keymap.set("n", "<leader>w+", "<cmd>vertical resize +5<CR>", { desc = "Increase width" })
vim.keymap.set("n", "<leader>w-", "<cmd>vertical resize -5<CR>", { desc = "Decrease width" })
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Balance windows" })
