-- https://nvim-mini.org/mini.nvim/readmes/mini-pairs.html
return {
    'echasnovski/mini.pairs',
    version = '*',
    event = 'InsertEnter', -- load when entering insert mode
    config = function()
        require('mini.pairs').setup {
            -- You can customize behavior here (optional)
            modes = { insert = true, command = false },
            mappings = {
                -- Opening brackets
                ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
                ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
                ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

                -- Closing brackets
                [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
                [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
                ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

                -- Quotes (smart)
                ['"'] = {
                    action = 'closeopen',
                    pair = '""',
                    neigh_pattern = '[^%w\\]',
                    register = { cr = false },
                },
                ["'"] = {
                    action = 'closeopen',
                    pair = "''",
                    neigh_pattern = '[^%w\\]',
                    register = { cr = false },
                },
                ['`'] = {
                    action = 'closeopen',
                    pair = '``',
                    neigh_pattern = '[^%w\\]',
                    register = { cr = false },
                },
            },
            delete = true, -- enable smart delete
            close_if_last = true,
            fast_wrap = {}, -- advanced wrap (optional)
        }
    end,
}
