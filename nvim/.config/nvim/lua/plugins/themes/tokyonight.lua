return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        ------------------------------------------------------------------
        -- 🔧 MANUAL BACKGROUND MODE (CHANGE THIS WHEN YOU WANT)
        ------------------------------------------------------------------
        local background_mode = 'dark' -- "light" | "dark"
        ------------------------------------------------------------------

        vim.o.background = background_mode

        -- Transparency toggle state
        local transparent = false

        -- Apply TokyoNight (equivalent to require('nord').set())
        local apply = function()
            require('tokyonight').setup {
                style = 'moon', -- used when background = dark
                light_style = 'day', -- used when background = light
                transparent = transparent,
                terminal_colors = true,

                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    sidebars = 'dark',
                    floats = 'dark',
                },

                day_brightness = 0.3,
                dim_inactive = false,
                lualine_bold = false,
                cache = true,
            }

            -- ✅ THIS is the equivalent of require('nord').set()
            vim.cmd.colorscheme 'tokyonight'
        end

        -- Apply once on startup
        apply()

        ------------------------------------------------------------------
        -- 🔁 Toggle transparency (same behavior as Nord)
        ------------------------------------------------------------------
        vim.keymap.set('n', '<leader>bg', function()
            transparent = not transparent
            apply()
        end, { noremap = true, silent = true, desc = 'Toggle TokyoNight transparency' })
    end,
}
