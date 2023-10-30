return {
  { 'numToStr/Comment.nvim',          opts = {} },
  { 'folke/which-key.nvim',           opts = {} },
  { 'lukas-reineke/virt-column.nvim', opts = {}, config = true },
  { 'stevearc/dressing.nvim',         opts = {} },
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    opts = {
      indent = { char = "│", },
      scope = { enabled = false, },
      whitespace = { remove_blankline_trail = true },
      exclude = {
        filetypes = { "help", "alpha", "dashboard", "Trouble", "lazy", "neo-tree" },
      },
    },
    main = "ibl",
  }
}
