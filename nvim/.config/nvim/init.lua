-------------------------------------------------------------------------------
-- 1. GLOBALS (Must be first)
-------------------------------------------------------------------------------
-- Set <space> as leader (must happen before other plugins loaded)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-------------------------------------------------------------------------------
-- 2. OPTIONS
-------------------------------------------------------------------------------
-- Relative line numbers
vim.o.relativenumber = true
vim.o.number = true          -- display absolute line number instead of 0
vim.opt.swapfile = false     -- No more .swp files
vim.opt.backup = false       -- No backup files
vim.opt.undofile = true      -- Keep undo history even after closing
vim.opt.signcolumn = "yes:2" -- Always show sign column
vim.opt.colorcolumn = "120"  -- Show column at 100 characters

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
vim.opt.hlsearch = true

-- Optional: Hide the default "-- INSERT --" since the statusline shows it
vim.opt.showmode = false

-- Snappy escape
vim.o.ttimeoutlen = 1

-- Raise dialog if you close unsaved buffer (prevent mistakes)
vim.o.confirm = true

-- Sync vim and system clipboards
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-------------------------------------------------------------------------------
-- 3. PLUGINS (Bootstrapping/Loading)
-------------------------------------------------------------------------------
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
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },
})

-------------------------------------------------------------------------------
-- 4. PLUGIN CONFIGURATIONS
-------------------------------------------------------------------------------

-- Gruvbox & Colorscheme
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
  contrast = "soft",
  transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")

-- Mini Modules
require('mini.icons').setup({ style = 'glyph' })
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
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
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
    signs = {
      add          = ' ',
      change       = ' ',
      delete       = ' ',
      topdelete    = '󱅁 ',
      changedelete = '󱅃 ',
    },
  },
  mappings = {
    apply      = '<leader>hs', -- Stage hunk
    reset      = '<leader>hr', -- Reset hunk
    goto_first = '[H',
    goto_prev  = '[h',
    goto_next  = ']h',
    goto_last  = ']H',
  },
})
require('mini.jump2d').setup({
  view = { dim = true }
})

-- Statusline (Lualine)
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = { 'Otree', 'alpha', 'lazy' },
      winbar = { 'Otree' },
    },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { { 'mode', fmt = function(str) return ' ' .. str end } },
    lualine_b = { 'branch' },
    lualine_c = { { 'filename', file_status = true, path = 1 } },
    lualine_x = {
      { 'diagnostics', sources = { 'nvim_diagnostic' }, symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }, colored = false },
      { 'diff', colored = false, symbols = { added = ' ', modified = ' ', removed = ' ' } },
      'encoding',
      'filetype'
    },
    lualine_y = { 'location' },
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

-- FzfLua
require("fzf-lua").setup({
  keymap = {
    builtin = {
      ["<C-d>"] = "preview-page-down",
      ["<C-u>"] = "preview-page-up",
    },
  },
})

-- Oil.nvim
require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})

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

-- Neoscroll
require("neoscroll").setup({
  hide_cursor = false,
  stop_eof = true,
  easing = "quadratic",
  duration_multiplier = 0.30,
})

-- Codediff
require("codediff").setup({})

-- Markdown
require("render-markdown").setup({})

-- DAP (Debugger)
local dap = require("dap")
dap.adapters.debugpy = function(cb, config)
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
dap.configurations.python = {
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

-- Mini.Clue (Must be after keymap definitions or at the end)
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

-------------------------------------------------------------------------------
-- 5. LSP & DIAGNOSTICS
-------------------------------------------------------------------------------
local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for name, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  underline = true,
  -- Use simple text for signs
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN]  = "W",
      [vim.diagnostic.severity.HINT]  = "H",
      [vim.diagnostic.severity.INFO]  = "I",
    },
  },
  float = { source = "if_many", border = "rounded" },
})

-- vtsls Vue integration
vim.lsp.config('vtsls', {
  filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue' },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
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
  "ty", "ruff", "lua_ls", "html", "cssls", "jsonls", "vue_ls", "vtsls", "tailwindcss",
})

-------------------------------------------------------------------------------
-- 6. KEYMAPS
-------------------------------------------------------------------------------

-- Basic movement
vim.keymap.set("n", "j", function() return vim.v.count == 0 and "gj" or "j" end,
  { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function() return vim.v.count == 0 and "gk" or "k" end,
  { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- Deleting (no yank)
vim.keymap.set("n", "x", '"_x', { desc = "Delete char (no yank)" })
vim.keymap.set("v", "d", '"_d', { desc = "Delete selection (no yank)" })
vim.keymap.set("v", "x", '"_x', { desc = "Delete selection (no yank)" })
vim.keymap.set("v", "p", '"_dP', { desc = "Paste (no yank)" })
vim.keymap.set("n", "c", '"_c', { desc = "Change (no yank)" })
vim.keymap.set("v", "c", '"_c', { desc = "Change (no yank)" })

-- Buffer Management
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete!<CR>", { desc = "Delete current buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>enew<CR>", { desc = "Create new buffer" })
vim.keymap.set("n", "<leader>bq", "<cmd>bdelete!<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>bQ", "<cmd>%bd|e#|bd#<CR>", { desc = "Close all other buffers" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bw", "<cmd>write<CR>", { desc = "Write buffer" })
vim.keymap.set("n", "<leader>bs", "ggVG", { desc = "Select all buffer" })
vim.keymap.set("n", "<leader>by", ":%y+<CR>", { desc = "Yank all buffer" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

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

-- Window Navigation
vim.keymap.set("n", "<C-Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- FzfLua Keymaps
vim.keymap.set("n", "<leader><Tab>", "<cmd>FzfLua files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>f/", "<cmd>FzfLua live_grep<cr>", { desc = "Find live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Find buffers" })

-- Diagnostic Keymaps
vim.keymap.set("n", "<leader>dt", vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Open Project Diagnostic List" })

-- Git/Diff Keymaps
vim.keymap.set("n", "<leader>ht", function() require("mini.diff").toggle_overlay(0) end,
  { desc = "Toggle mini.diff overlay" })
vim.keymap.set("n", "<leader>hd", "<cmd>CodeDiff<CR>", { desc = "Open CodeDiff (VS Code style)" })

-- DAP Keymaps
vim.keymap.set("n", "<leader>kb", dap.toggle_breakpoint, { desc = "Debug toggle breakpoint" })
vim.keymap.set("n", "<leader>kc", dap.continue, { desc = "Debug continue" })
vim.keymap.set("n", "<leader>kq", dap.terminate, { desc = "Debug terminate" })
vim.keymap.set("n", "<leader>kR", dap.repl.open, { desc = "Debug open REPL" })
vim.keymap.set("n", "<leader>kL", dap.run_last, { desc = "Debug run last" })
vim.keymap.set({ "n", "v" }, "<leader>dh", require("dap.ui.widgets").hover, { desc = "Debug hover" })
vim.keymap.set("n", "<leader>ks",
  function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes) end, { desc = "Debug scopes" })
vim.keymap.set("n", "<leader>kl", dap.step_over, { desc = "Debug: Step Over (Down)" })
vim.keymap.set("n", "<leader>ks", dap.step_into, { desc = "Debug: Step Into (Right)" })
vim.keymap.set("n", "<leader>kk", dap.step_out, { desc = "Debug: Step Out (Left)" })
vim.keymap.set("n", "<leader>kr", dap.restart_frame, { desc = "Debug: Restart (Up)" })

-- File Tree Keymap
vim.keymap.set("n", "<leader>e", "<cmd>Otree<cr>", { desc = "Toggle Otree" })

-- Oil Keymap
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-------------------------------------------------------------------------------
-- 7. AUTOCOMMANDS
-------------------------------------------------------------------------------

-- Stop automatic comment continuation
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Stop Neovim from automatically starting a new comment line",
})

-- Highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Treesitter fallback
vim.cmd('syntax off')
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    if not pcall(vim.treesitter.start) then
      vim.cmd('syntax on')
    end
  end,
})

-- LSP Attach (Formatting on save logic)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    local bufnr = ev.buf
    local filetype = vim.bo[bufnr].filetype

    -- LUA formatting
    if filetype == "lua" then
      if client.name == "lua_ls" and client:supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("LspFormatLua." .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 }) end,
        })
      end
    end

    -- PYTHON formatting
    if filetype == "python" then
      if client.name == "ruff" and client:supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("LspFormatPython." .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.code_action({ context = { only = { "source.organizeImports.ruff" } }, apply = true })
            vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
            vim.api.nvim_echo({ { "Ruff: Imports sorted & Formatted", "None" } }, false, {})
          end,
        })
      end
    end

    -- HTML/CSS formatting
    if filetype == "html" or filetype == "css" then
      if (client.name == "html" or client.name == "cssls") and client:supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("LspFormatWeb." .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 }) end,
        })
      end
    end

    -- JS/TS formatting
    if filetype == "javascript" or filetype == "typescript" then
      if client.name == "vtsls" and client:supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("LspFormatJS." .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.execute_command({ command = "typescript.organizeImports", arguments = { vim.api.nvim_buf_get_name(bufnr) } })
            vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
          end,
        })
      end
    end

    -- JSON formatting
    if filetype == "json" or filetype == "jsonc" then
      if client.name == "jsonls" and client:supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("LspFormatJson." .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 }) end,
        })
      end
    end

    -- VUE formatting
    if filetype == "vue" then
      if client.name == "vue_ls" and client:supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("LspFormatVue." .. bufnr, { clear = true }),
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 }) end,
        })
      end
    end
  end,
})
