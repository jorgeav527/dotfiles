return {
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
            { '<leader>n', group = 'Next', icon = '󰒭 ' },
            { '<leader>p', group = 'Previous', icon = '󰒮 ' },
            { '<leader>c', group = 'Code', icon = '󰅨' },
            { '<leader>s', group = 'Search/Replace (Spectre)', icon = '󰛔 ' },
            { '<leader>e', icon = '󰙅 ', desc = 'Left Explorer' },
            { '<leader>E', icon = '󰭔 ', desc = 'Float Explorer' },
            { '<leader>G', icon = '󰊢 ', desc = 'Float Git Status' },
            { '<leader>g', desc = 'Git' },
            { '<leader>h', desc = 'GitHub' },
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
}
