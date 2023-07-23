return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function(_, opts)
    local logo = [[

    ]]
    opts.section.header.val = vim.split(logo, "\n", { triempty = true })
  end,
}
