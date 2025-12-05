-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

---------------------------------------------------------------
-- 🧠 Neovim Providers (Python & Node for plugins like pynvim)
---------------------------------------------------------------

-- Path to Python used by Neovim plugins (virtualenv recommended)
vim.g.python3_host_prog = vim.fn.expand("~/.local/share/nvim/venv/bin/python")

-- Path to Node.js Neovim provider (used by some plugins)
vim.g.node_host_prog = vim.fn.expand("~/.local/share/nvim/node/node_modules/neovim/bin/cli.js")

-- Allow left and right arrow keys to move to the previous and next line.
vim.opt.whichwrap = "b,s,<,>"

-- Show a vertical line at this character.
vim.opt.colorcolumn = "100"

-- Wrap lines so it's easier to see anything that's cut off.
vim.opt.wrap = true
