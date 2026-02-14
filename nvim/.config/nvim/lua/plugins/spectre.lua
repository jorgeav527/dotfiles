return {
    'nvim-pack/nvim-spectre',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    keys = {
        {
            '<leader>st',
            function()
                require('spectre').toggle()
            end,
            desc = 'Toggle Spectre',
        },
        {
            '<leader>sg',
            function()
                require('spectre').open_visual { select_word = true }
            end,
            desc = 'Search current word globaly',
        },
        {
            '<leader>s.',
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
        --         vim.keymap.set('x', '<leader>S', '<Nop>', { desc = 'Prefix for Spectre (Visual)' })

        --         vim.keymap.set('v', '<leader>Sg', function()
        --             require('spectre').open_visual()
        --         end, { desc = 'Search selection globally' })

        --         vim.keymap.set('v', '<leader>S.', function()
        --             require('spectre').open_file_search()
        --         end, { desc = 'Search selection locally' })
    end,
}
