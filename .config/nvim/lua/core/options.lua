-- [[ Setting options ]]
-- See `:help vim.opt`
-- For more options, you can see `:help option-list`

-- Make relative line numbers the default, but also show the current line number
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits.
vim.opt.mouse = 'a'

-- Don't show the mode. It's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
vim.o.undolevels = 10000

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight on search
vim.opt.hlsearch = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type
vim.opt.inccommand = 'split'

-- Show which line your cursor is on (always 80 chars of highlighting)
vim.o.colorcolumn = "80"
vim.opt.cursorline = true

-- Number of screen lines to keep for context when scrolling
vim.opt.scrolloff = 10

-- Number of coloumns to keep for context when side scrolling
vim.opt.sidescrolloff = 10

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menu,menuone,preview,noselect,fuzzy'

-- 24-bit colour
vim.opt.termguicolors = true

-- Disable swapfiles and backup files
vim.o.swapfile = false
vim.o.backup = false

 -- Use spaces instead of tabs
vim.o.expandtab = true

-- Number of spaces that replace a tab
vim.o.tabstop = 4

-- Indent size in spaces
vim.o.shiftwidth = 4

 -- Insert indents automatically
vim.o.smartindent = true

-- Grep options
-- Define how grep results are formatted: file:line:column:message
vim.o.grepformat = "%f:%l:%c:%m"

-- Use ripgrep (rg) instead of grep for faster searching with --vimgrep flag
-- for vim-compatible output format
vim.o.grepprg = "rg --vimgrep"

-- Global status line
vim.o.laststatus = 3

-- Popup menu options
vim.o.pumblend = 10
vim.o.pumheight = 20

-- Allow cursor to move where there is no text in visual block mode
vim.o.virtualedit = "block"

-- Command-line completion mode
vim.o.wildmode = "longest:full,full"

-- Minimum window width
vim.o.winminwidth = 5
vim.o.winborder = 'rounded'

-- Disable line wrap
vim.o.wrap = false

-- -- Set color column at 80 cols
-- vim.opt.colorcolumn = "80"

-- Enable smooth scroll if available
if vim.fn.has("nvim-0.10") == 1 then
    vim.o.smoothscroll = true
end

-- vim.g.markdown_recommended_style = 0
vim.g.have_nerd_font = true

-- Folding options
-- Use expressions for folding (treesitter)
vim.opt.foldmethod = "expr"
-- Use treesitter for fold rules
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- Don't show fold indicators in the gutter
vim.opt.foldcolumn = "0"
-- No custom fold text display
vim.opt.foldtext = ""
-- Start with all folds open
vim.opt.foldlevel = 99
-- Open all folds when opening a file
vim.opt.foldlevelstart = 99
-- Maximum nesting of folds (prevent deep nesting)
vim.opt.foldnestmax = 3


return {}
