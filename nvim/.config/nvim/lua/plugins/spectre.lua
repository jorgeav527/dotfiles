return {
    'nvim-pack/nvim-spectre',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    keys = {
        {
            '<leader>St',
            function()
                require('spectre').toggle()
            end,
            desc = 'Toggle Spectre',
        },
        {
            '<leader>Sg',
            function()
                require('spectre').open_visual { select_word = true }
            end,
            desc = 'Search current word globaly',
        },
        {
            '<leader>S.',
            function()
                require('spectre').open_file_search { select_word = true }
            end,
            desc = 'Search on current word localy',
        },
    },
    config = function()
        require('spectre').setup {
            result_padding = '',
            default = {
                replace = {
                    cmd = 'sed', -- correct for Linux
                },
            },
        }

        -- visual mode mapping must be set manually
        -- vim.keymap.set('x', '<leader>S', '<Nop>', { desc = 'Prefix for Spectre (Visual)' })
        --
        -- vim.keymap.set('x', '<leader>Sg', function()
        --     require('spectre').open_visual()
        -- end, { desc = 'Search selection globally (Spectre)' })
        --
        -- vim.keymap.set('x', '<leader>S.', function()
        --     require('spectre').open_file_search()
        -- end, { desc = 'Search selection locally (Spectre)' })
    end,
}
