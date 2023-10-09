return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      style = "night",
      on_highlights = function(hl, c)
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.dark5,
        }
      end,
    },
  },
}
