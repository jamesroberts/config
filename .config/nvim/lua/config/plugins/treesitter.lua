-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter` Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
-- See `:help cmp`
local configure = function()
  vim.defer_fn(function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim',
        'bash', 'json' },
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
      },
    }
  end, 0)
end

return {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = configure
  },
}
