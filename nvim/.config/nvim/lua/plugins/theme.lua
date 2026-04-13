return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
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
            contrast = "", -- "" (medium), "hard", or "soft"
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
        })

        -- Actually apply the colorscheme
        vim.cmd("colorscheme gruvbox")
    end,
}
