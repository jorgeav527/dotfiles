return {
    'jpwol/thorn.nvim',
    lazy = false,
    priority = 1000,
    config = function(_, opts)
        require('thorn').setup(opts)
        vim.cmd.colorscheme 'thorn'
    end,
    opts = {
        theme = 'dark',
        background = 'warm',
        transparent = false,
        terminal = true,
        styles = {
            keywords = { italic = true, bold = false },
            comments = { italic = true, bold = false },
            strings = { italic = true, bold = false },

            diagnostic = {
                underline = true, -- if true, flat underlines will be used. Otherwise, undercurls will be used

                -- true will apply the bg highlight, false applies the fg highlight
                error = { highlight = true },
                hint = { highlight = false },
                info = { highlight = false },
                warn = { highlight = false },
            },
        },
        on_highlights = function(hl, palette)
            -- you can also use the theme's palette
            hl.String = { fg = palette.lightgreen }
            hl.Function.fg = '#D9ADD4'
        end,
    },
}
