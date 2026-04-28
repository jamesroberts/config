return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        transparent = true,
        styles = {
            sidebars = "transparent",
            floats = "transparent",
        },
        opts = {
            style = "night",
            on_colors = function(colors)
            end
        },
        config = function()
            local styles = require("tokyonight.colors").styles
            local darker_colors = {
              bg = "#000000",
              bg_dark = "#000000",
            }
            styles.night = vim.tbl_extend("force", styles.night, darker_colors)
            vim.cmd.colorscheme 'tokyonight-night'
            require('lualine').setup({
                options = { theme = 'tokyonight-night' }
            })
        end,
    }
}
