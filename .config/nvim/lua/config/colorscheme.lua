return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",
            on_highlights = function(hl, c)
                hl.WinSeparator = { bg = c._bg, fg = c._bg }
            end,
            on_colors = function(colors)
                colors._bg = colors.bg
                colors.bg = colors.bg_dark
            end
        },
        config = function()
            vim.cmd [[colorscheme tokyonight-night]]
            require('lualine').setup({
                options = { theme = 'tokyonight' }
            })
        end,
    }
}
