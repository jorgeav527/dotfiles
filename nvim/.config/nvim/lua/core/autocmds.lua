-- Custom code snippets for different purposes
-- -------------------------
-- Cursorline Highlighting
-- -------------------------
local cursorline_group = vim.api.nvim_create_augroup('cursorline', { clear = true })

vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
    group = cursorline_group,
    callback = function()
        vim.opt_local.cursorline = true
    end,
})

vim.api.nvim_create_autocmd('WinLeave', {
    group = cursorline_group,
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.hl.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

-- Appearance of diagnostics
vim.diagnostic.config {
    virtual_text = {
        prefix = '●',
        -- Add a custom format function to show error codes
        format = function(diagnostic)
            local code = diagnostic.code and string.format('[%s]', diagnostic.code) or ''
            return string.format('%s %s', code, diagnostic.message)
        end,
    },
    underline = false,
    update_in_insert = true,
    float = {
        source = true, -- Or "if_many"
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
            [vim.diagnostic.severity.HINT] = '󰌵 ',
        },
    },
    -- Make diagnostic background transparent
    on_ready = function()
        vim.cmd 'highlight DiagnosticVirtualText guibg=NONE'
    end,
}

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- -------------------------
-- Makefile Settings
-- -------------------------
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'make' },
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.shiftwidth = 4
    end,
})

-- -------------------------
-- Detect Helm YAML
-- -------------------------
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '*.yaml', '*.yml' },
    callback = function()
        if vim.fn.getline(1):match '^apiVersion:' or vim.fn.getline(2):match '^apiVersion:' then
            vim.opt_local.filetype = 'helm'
        end
    end,
})
