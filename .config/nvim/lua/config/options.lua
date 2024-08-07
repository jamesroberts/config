-- [[ Setting options ]]
-- See `:help vim.opt`
-- For more options, you can see `:help option-list`

-- Make relative line numbers the default, but show the current line
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

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

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Number of screen lines to keep for context when scrolling
vim.opt.scrolloff = 10

-- Number of coloumns to keep for context when side scrolling
vim.o.sidescrolloff = 10

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menu,menuone,noselect'

-- 24-bit colour
vim.o.termguicolors = true

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

 -- Hide * markup for bold and italic
vim.o.conceallevel = 3

-- Grep options
vim.o.grepformat = "%f:%l:%c:%m"
vim.o.grepprg = "rg --vimgrep"

-- Global status line
vim.o.laststatus = 3         -- global statusline

-- Popup menu options
vim.o.pumblend = 10
vim.o.pumheight = 15

-- Allow cursor to move where there is no text in visual block mode
vim.o.virtualedit = "block"

-- Command-line completion mode
vim.o.wildmode = "longest:full,full"

-- Minimum window width
vim.o.winminwidth = 5

-- Disable line wrap
vim.o.wrap = false

-- Set color column at 80 cols
vim.o.colorcolumn = "80"

-- Enable smmoth scroll if available
if vim.fn.has("nvim-0.10") == 1 then
    vim.o.smoothscroll = true
end

vim.g.markdown_recommended_style = 0

vim.g.have_nerd_font = true
