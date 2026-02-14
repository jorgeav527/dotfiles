-- Standalone plugins with less than 10 lines of config go here
return {
    {
        -- Detect tabstop and shiftwidth automatically
        'tpope/vim-sleuth',
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = function(_, opts)
            local wk = require 'which-key'

            -- 1. Setup the visual appearance (your borders and delay)
            wk.setup(opts)

            -- 2. Register your custom groups
            wk.add {
                { '<leader>d', group = 'Diagnostics', icon = '󰒡' }, -- Optional icon
                { '<leader>b', group = 'Buffers' },
                { '<leader>f', group = 'Find (Telescope)', icon = '󰍉' },
                { '<leader><leader>', icon = '󰍉', desc = '[Tab] Find Files' },
                { '<leader><tab>', icon = '󰍉', desc = '[Leader] Search by Grep' },
                { '<leader>fo', icon = '󰍉', desc = '[F]ind [O]ld Recent Files' },
                { '<leader>f.', icon = '󰍉', desc = '[F]ind in current [.] Buffer' },
            }
        end,
        -- Your visual settings move here
        opts = {
            delay = 500,
            win = {
                border = {
                    { '┌', 'FloatBorder' },
                    { '─', 'FloatBorder' },
                    { '┐', 'FloatBorder' },
                    { '│', 'FloatBorder' },
                    { '┘', 'FloatBorder' },
                    { '─', 'FloatBorder' },
                    { '└', 'FloatBorder' },
                    { '│', 'FloatBorder' },
                },
            },
        },
    },
    {
        -- Highlight todo, notes, etc in comments
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
    },
    {
        -- High-performance color highlighter
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
    },
}
