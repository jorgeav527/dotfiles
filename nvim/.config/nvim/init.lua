-- Set <space> as leader (must happen before other plugins loaded)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Relative line numbers
vim.o.relativenumber = true
vim.o.number = true         -- display absolute line number instead of 0
vim.opt.swapfile = false    -- No more .swp files
vim.opt.backup = false      -- No backup files
vim.opt.undofile = true     -- Keep undo history even after closing
vim.opt.signcolumn = "yes"  -- Always show sign column
vim.opt.colorcolumn = "120" -- Show column at 100 characters
vim.opt.laststatus = 3      -- Force the statusline to use a single bar at the bottom


-- Case-insensitive searching unless we use capital letters
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.iskeyword:append("-")

-- Global Indentation (2 spaces)
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.opt.splitbelow = true -- Horizontal splits open below
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.cursorline = true -- Highlight the text line of the cursor

-- Basic movement
vim.keymap.set("n", "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

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
vim.keymap.set("n", "<leader>bq", "<cmd>bdelete!<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>bQ", "<cmd>%bd|e#|bd#<CR>", { desc = "Close all other buffers" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bw", "<cmd>write<CR>")
vim.keymap.set("n", "<leader>bs", "ggVG")
vim.keymap.set("n", "<leader>by", ":%y+<CR>")

-- Copy Paths
vim.keymap.set("n", "<leader>ba", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied absolute path: " .. path)
end, { desc = "Copy Absolute Path" })

vim.keymap.set("n", "<leader>br", function()
  local fullpath = vim.fn.expand("%:p")
  local cwd = vim.fn.getcwd()
  cwd = cwd:gsub("([%-%.%+%[%]%(%)%$%^%%%?%*])", "%%%1")
  local relative = fullpath:gsub("^" .. cwd .. "/", "")
  vim.fn.setreg("+", relative)
  vim.notify("Copied relative path: " .. relative)
end, { desc = "Copy Relative Path" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Stop Neovim from automatically starting a new comment line",
})

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Sync vim and system clipboards
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- Raise dialog if you close unsaved buffer (prevent mistakes)
vim.o.confirm = true

-- Snappy escape
vim.o.ttimeoutlen = 1

-- Vim diagnostics
vim.diagnostic.config({
  severity_sort = true,           -- show most severe error first
  update_in_insert = false,       -- don't update while typing
  float = { source = "if_many" }, -- nicer look for floats and show source if multiple sources (ex. ruff and ty)
  on_jump = { float = true },     -- automatically open the diagnostic float if you jump with [d ]d
})

-- Show diagnostics
vim.keymap.set("n", "<leader>lt", vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>ld", vim.diagnostic.setqflist, { desc = "Open Project Diagnostic List" })

-- Easily move between windows
vim.keymap.set("n", "<C-Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Plugins
-- Pack guide: https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack#update
vim.pack.add({
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-treesitter/nvim-treesitter", -- also $ brew install tree-sitter-cli
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/karb94/neoscroll.nvim",
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/Eutrius/Otree.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/esmuellert/codediff.nvim",
  "https://github.com/goolord/alpha-nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") }, -- pinning so rust binary dependency automatically downloads
})

-- Grubox
require("gruvbox").setup({
  terminal_colors = true,
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true,
  contrast = "soft", -- can be "hard", "soft" or empty string
  transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")

-- Mini
require('mini.icons').setup({ style = 'glyph' })
require('mini.icons').mock_nvim_web_devicons()
require('mini.diff').setup({
  view = {
    style = 'sign',
  },
  mappings = {
    -- Navigation through your changes
    line_right = "<A-Right>",
    line_down = "<A-Down>",
    line_up = "<A-Up>",
  },
})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.surround").setup({})
require("mini.trailspace").setup({})

-- Statusline
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'auto', -- Matches your Base2Tone Forest colors
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = { 'Otree', 'alpha', 'lazy' },
      winbar = { 'Otree' },
    },
    always_divide_middle = true,
    globalstatus = true, -- One bar at the bottom, even with splits
  },
  sections = {
    -- Left side
    lualine_a = {
      {
        'mode',
        fmt = function(str) return ' ' .. str end
      }
    },
    lualine_b = { 'branch' }, -- Shows your Git branch here
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 1 -- 1 = Relative path (e.g. .config/nvim/init.lua)
      }
    },

    -- Right side
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
        colored = false,
      },
      {
        'diff',
        colored = false,
        symbols = { added = ' ', modified = ' ', removed = ' ' },
      },
      'encoding',
      'filetype'
    },
    lualine_y = { 'location' }, -- Horizontal | Vertical position
    lualine_z = { 'progress' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { { 'location', padding = 0 } },
    lualine_y = {},
    lualine_z = {},
  },
})

-- Optional: Hide the default "-- INSERT --" since the statusline shows it
vim.opt.showmode = false

vim.keymap.set("n", "<leader>gt", function()
  require("mini.diff").toggle_overlay(0)
end, { desc = "Toggle mini.diff overlay" })

require('mini.indentscope').setup({})

-- Markdown
require("render-markdown").setup({})

-- FzfLua Setup
require("fzf-lua").setup({
  keymap = {
    builtin = {
      ["<C-d>"] = "preview-page-down", -- Better scrolling within the displays
      ["<C-u>"] = "preview-page-up",
    },
  },
})

vim.keymap.set("n", "<leader><Tab>", "<cmd>FzfLua files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>f/", "<cmd>FzfLua live_grep<cr>", { desc = "Find live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Find buffers" })

-- Treesitter
vim.cmd('syntax off') -- Make it obvious if treesitter is missing
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    if not pcall(vim.treesitter.start) then
      vim.cmd('syntax on')
    end
  end,
})

-- LSP
-- 1. Configure vtsls to work with Vue
vim.lsp.config('vtsls', {
  filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue' },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            -- Updated path based on your 'npm list -g' output
            location = '/home/jorgeav527/.nvm/versions/node/v24.11.1/lib/node_modules/@vue/language-server',
            languages = { 'vue' },
            configNamespace = 'typescript',
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
    },
  },
})

vim.lsp.enable({
  -- Debian 12
  "ty",   -- also $ uv tool install ty@latest
  "ruff", -- also $ uv tool install ruff@latest
  -- # Create a permanent home for the server
  -- mkdir -p ~/.local/share/lua-ls
  -- cd ~/.local/share/lua-ls
  -- # Download the specific file you identified
  -- curl -L -O https://github.com/LuaLS/lua-language-server/releases/download/3.18.2/lua-language-server-3.18.2-linux-x64.tar.gz
  -- # Unpack it
  -- tar -xzf lua-language-server-3.18.2-linux-x64.tar.gz
  -- sudo ln -s ~/.local/share/lua-ls/bin/lua-language-server /usr/local/bin/lua-language-server
  "lua_ls",
  -- npm install -g vscode-langservers-extracted
  "html",   -- HTML
  "cssls",  -- CSS
  "jsonls", -- JSON
  -- npm install -g @vue/language-server
  -- npm install -g @vtsls/language-server
  -- npm install -g typescript
  "vue_ls",              -- Vue
  "vtsls",               -- Modern JS/TS replacement for tsserver
  -- npm install -g @tailwindcss/language-server
  "tailwindcss",         -- Tailwindcss
})
vim.o.signcolumn = "yes" -- make lsp warnings not widen the gutter
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    local bufnr = ev.buf
    local filetype = vim.bo[bufnr].filetype

    -----------------------------------------
    -- 1. LUA SPECIFIC CONFIG
    -----------------------------------------
    if filetype == "lua" then
      -- Logic:
      -- A) Is this the lua_ls client?
      -- B) Does it know how to format?
      -- C) Does it NOT handle its own formatting on save?
      if client.name == "lua_ls"
          and client:supports_method("textDocument/formatting")
          and not client:supports_method("textDocument/willSaveWaitUntil")
      then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("LspFormatLua." .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
          end,
        })
      end
    end

    -----------------------------------------
    -- 2. PYTHON: ruff (Format + Imports)
    -----------------------------------------
    if filetype == "python" then
      -- We only attach the Save trigger to Ruff, not 'ty'
      if client.name == "ruff"
          and client:supports_method("textDocument/formatting")
          and not client:supports_method("textDocument/willSaveWaitUntil")
      then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("LspFormatPython." .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function()
            -- Organize Imports first
            vim.lsp.buf.code_action({
              context = { only = { "source.organizeImports.ruff" } },
              apply = true,
            })

            -- Then Format
            vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })

            -- Visible confirmation (optional)
            vim.api.nvim_echo({ { "Ruff: Imports sorted & Formatted", "None" } },
              false, {})
          end,
        })
      end
    end


    -----------------------------------------
    -- 3. HTML & CSS
    -----------------------------------------
    if filetype == "html" or filetype == "css" then
      if (client.name == "html" or client.name == "cssls")
          and client:supports_method("textDocument/formatting")
      then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("LspFormatWeb." .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
          end,
        })
      end
    end

    -----------------------------------------
    -- 4. JAVASCRIPT & TYPESCRIPT (vtsls)
    -----------------------------------------
    if filetype == "javascript" or filetype == "typescript" then
      if client.name == "vtsls"
          and client:supports_method("textDocument/formatting")
      then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("LspFormatJS." .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function()
            -- Organize Imports (similar to your Ruff logic)
            vim.lsp.buf.execute_command({
              command = "typescript.organizeImports",
              arguments = { vim.api.nvim_buf_get_name(bufnr) }
            })
            -- Format
            vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
          end,
        })
      end
    end

    -----------------------------------------
    -- 5. JSON
    -----------------------------------------
    if filetype == "json" or filetype == "jsonc" then
      if client.name == "jsonls"
          and client:supports_method("textDocument/formatting")
      then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("LspFormatJson." .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
          end,
        })
      end
    end

    -----------------------------------------
    -- 6. VUE (Volar)
    -----------------------------------------
    if filetype == "vue" then
      if client.name == "vue_ls"
          and client:supports_method("textDocument/formatting")
      then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("LspFormatVue." .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
          end,
        })
      end
    end
  end,
})

-- Blink.cmp
require("blink.cmp").setup({
  keymap = {
    preset = 'default',
    ['<C-e>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
  },
})

-- Neoscroll
require("neoscroll").setup({
  hide_cursor = false,
  stop_eof = true,
  easing = "quadratic",
  duration_multiplier = 0.30,
})

-- Dap (debugging)
local dap = require("dap")
dap.adapters.debugpy = function(cb, config) -- also $ uv tool install debugpy@latest
  if config.request == "attach" then
    cb({
      type = "server",
      port = config.connect.port,
      host = config.connect.host or "127.0.0.1",
    })
  else
    cb({
      type = "executable",
      command = "debugpy-adapter",
    })
  end
end
dap.configurations.python = { -- https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
  {
    type = "debugpy",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    python = function()
      local root = vim.fs.root(0, ".venv")
      return { root and root .. "/.venv/bin/python" or "python3" }
    end,
    cwd = function()
      return vim.fs.root(0, ".venv") or vim.fn.getcwd()
    end,
  },
}
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug continue" })
vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Debug terminate" })
vim.keymap.set("n", "<leader>dR", dap.repl.open, { desc = "Debug open REPL" })
vim.keymap.set("n", "<leader>dL", dap.run_last, { desc = "Debug run last" })
vim.keymap.set({ "n", "v" }, "<leader>dh", require("dap.ui.widgets").hover, { desc = "Debug hover" })
vim.keymap.set("n", "<leader>ds", function()
  require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes)
end, { desc = "Debug scopes" })

vim.keymap.set("n", "<leader>dl", dap.step_over, { desc = "Debug: Step Over (Down)" })
vim.keymap.set("n", "<leader>dj", dap.step_into, { desc = "Debug: Step Into (Right)" })
vim.keymap.set("n", "<leader>dk", dap.step_out, { desc = "Debug: Step Out (Left)" })
vim.keymap.set("n", "<leader>dr", dap.restart_frame, { desc = "Debug: Restart (Up)" })

-- Otree
require("Otree").setup({
  show_hidden = true,
  show_ignore = true,
  git_signs = true,
  lsp_signs = true,
  use_default_keymaps = false,
  keymaps = {
    ["<CR>"] = "actions.select",
    ["l"] = "actions.select",
    ["c"] = "actions.close_dir",
    ["<Esc>"] = "actions.close_win",
    ["p"] = "actions.goto_parent",
    ["gd"] = "actions.goto_dir",
    ["gD"] = "actions.goto_home_dir",
    ["cd"] = "actions.change_home_dir",
    ["L"] = "actions.open_dirs",
    ["C"] = "actions.close_dirs",
    ["o"] = "actions.oil_dir",
    ["O"] = "actions.oil_into_dir",
    ["t"] = "actions.open_tab",
    ["v"] = "actions.open_vsplit",
    ["h"] = "actions.open_split",
    ["."] = "actions.toggle_hidden",
    ["i"] = "actions.toggle_ignore",
    ["r"] = "actions.refresh",
    ["f"] = "actions.focus_file",
    ["?"] = "actions.open_help",
  },
})

vim.keymap.set("n", "<leader>e", "<cmd>Otree<cr>", { desc = "Toggle Otree" })

-- Oil.nvim
require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Codediff (vscode like diffs :))
require("codediff").setup({})
