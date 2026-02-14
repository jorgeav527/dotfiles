return {
    'AndrewRadev/splitjoin.vim',
    event = 'VeryLazy',
    config = function()
        -- Optional: Disable default gS / gJ if you only want to use leader
        vim.g.splitjoin_split_mapping = ''
        vim.g.splitjoin_join_mapping = ''

        -- Map to leader
        vim.keymap.set('n', '<leader>cj', ':SplitjoinJoin<cr>', { desc = 'Join (Single-line)' })
        vim.keymap.set('n', '<leader>cs', ':SplitjoinSplit<cr>', { desc = 'Split (Multi-line)' })
    end,
} -- https://github.com/AndrewRadev/splitjoin.vim
