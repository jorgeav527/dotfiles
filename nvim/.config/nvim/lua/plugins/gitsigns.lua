return {
    'lewis6991/gitsigns.nvim',
    opts = {
        ------------------------------------------------------------------
        -- SIGNS
        ------------------------------------------------------------------
        signs = {
            add = { text = '┃' },
            change = { text = '┃' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
            untracked = { text = '┆' },
        },
        signs_staged = {
            add = { text = '┃' },
            change = { text = '┃' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
            untracked = { text = '┆' },
        },
        signs_staged_enable = true,
        signcolumn = true,
        numhl = true,
        linehl = false,
        word_diff = false,
        watch_gitdir = { follow_files = true },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = false,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol',
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
            use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R>',

        sign_priority = 6,
        update_debounce = 100,
        max_file_length = 40000,

        preview_config = {
            style = 'minimal',
            border = 'rounded',
            relative = 'cursor',
            row = 0,
            col = 1,
        },

        ------------------------------------------------------------------
        -- ✅ on_attach MUST BE HERE
        ------------------------------------------------------------------
        on_attach = function(bufnr)
            local gitsigns = require 'gitsigns'

            local function map(mode, lhs, rhs, opts)
                if type(opts) == 'string' then
                    opts = { desc = opts }
                end
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, lhs, rhs, opts)
            end

            -- Next Hunk (Git change)
            map('n', '<leader>nh', function()
                if vim.wo.diff then
                    vim.cmd.normal { ']h', bang = true }
                else
                    gitsigns.nav_hunk 'next'
                end
            end, { desc = '󰊢 Next Hunk' })

            -- Previous Hunk (Git change)
            map('n', '<leader>ph', function()
                if vim.wo.diff then
                    vim.cmd.normal { '[h', bang = true }
                else
                    gitsigns.nav_hunk 'prev'
                end
            end, { desc = '󰊢 Prev Hunk' })

            -- Hunks
            map('n', '<leader>hs', gitsigns.stage_hunk, '󰊢 Stage Hunk')
            map('n', '<leader>hr', gitsigns.reset_hunk, '󰊢 Reset Hunk')

            map('v', '<leader>hs', function()
                gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
            end, '󰊢 Stage Selection')

            map('v', '<leader>hr', function()
                gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
            end, '󰊢 Reset Selection')

            -- Buffer
            map('n', '<leader>hS', gitsigns.stage_buffer, '󰊢 Stage Buffer')
            map('n', '<leader>hR', gitsigns.reset_buffer, '󰊢 Reset Buffer')

            -- Preview / Diff
            map('n', '<leader>hp', gitsigns.preview_hunk, '󰊢 Preview Hunk')
            map('n', '<leader>hi', gitsigns.preview_hunk_inline, '󰊢 Preview Inline')
            map('n', '<leader>hd', gitsigns.diffthis, '󰊢 Diff Against Index')
            map('n', '<leader>hD', function()
                gitsigns.diffthis '~'
            end, '󰊢 Diff Against Last Commit')

            -- Blame
            map('n', '<leader>hb', function()
                gitsigns.blame_line { full = true }
            end, '󰊢 Full Blame Line')

            -- Quickfix
            map('n', '<leader>hq', gitsigns.setqflist, '󰊢 Hunks to Quickfix')
            map('n', '<leader>hQ', function()
                gitsigns.setqflist 'all'
            end, '󰊢 All Hunks to Quickfix')

            -- Toggles
            map('n', '<leader>tb', gitsigns.toggle_current_line_blame, '󰊢 Toggle Line Blame')
            map('n', '<leader>tw', gitsigns.toggle_word_diff, '󰊢 Toggle Word Diff')

            -- Text object (e.g., 'dah' to delete a hunk)
            map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, '󰊢 Select Hunk')
        end,
    },
}
