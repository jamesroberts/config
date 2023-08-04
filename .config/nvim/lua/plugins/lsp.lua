return {
  "neovim/nvim-lspconfig",
  opts = {
    autoformat = false,
    servers = {
      lua_ls = {},
      pyright = {},
      rust_analyzer = {},
      tsserver = {}
    },
  },
}
