vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set

-- navigation
map({ 'n', 'v' }, '<space>', '<nop>', { silent = true })
map("n", "<c-u>", "<c-u>zz", { noremap = true, silent = true, desc = "move viewport up" })
map("n", "<c-d>", "<c-d>zz", { noremap = true, silent = true, desc = "move viewport down" })
map("n", "<tab>", ":bnext<cr>", { noremap = true, silent = true, desc = "switch to next buffer" })
map("n", "<s-tab>", ":bprev<cr>", { noremap = true, silent = true, desc = "switch to prev buffer" })
map("n", "<leader>x<tab>", ":bd<cr>", { noremap = true, silent = true, desc = "close current buffer" })

-- move lines up and down
map("v", "k", ":m '<-2<cr>gv=gv", { noremap = true, silent = true, desc = "switch highlighted text up" })
map("v", "j", ":m '>+1<cr>gv=gv", { noremap = true, silent = true, desc = "switch highlighted text down" })

-- Start and end of line shortcuts
map({'n', 'x', 'o'}, 'H', '^')
map({'n', 'x', 'o'}, 'L', 'g_')

-- easy way to get back to normal mode from home row
map("i", "kj", "<esc>") -- kj simulates esc
map("i", "jk", "<esc>") -- jk simulates esc

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- files
map("n", "<leader>fx", "<cmd>!chmod +x %<cr>", { silent = true, desc = "make the current file executable" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "new file" })

-- terminal
map("n", "<leader>tt", vim.cmd.terminal, { noremap = true, silent = true, desc = "start terminal" })
map("t", "<esc>", "<c-\\><c-n>", { noremap = true, silent = true, desc = "escape terminal" })

-- lsp
map("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "go to definition" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- move to window using the <ctrl> hjkl keys
map("n", "<c-h>", "<c-w>h", { desc = "go to left window", remap = true })
map("n", "<c-j>", "<c-w>j", { desc = "go to lower window", remap = true })
map("n", "<c-k>", "<c-w>k", { desc = "go to upper window", remap = true })
map("n", "<c-l>", "<c-w>l", { desc = "go to right window", remap = true })

-- resize window using <ctrl> arrow keys
map("n", "<c-up>", "<cmd>resize +2<cr>", { desc = "increase window height" })
map("n", "<c-down>", "<cmd>resize -2<cr>", { desc = "decrease window height" })
map("n", "<c-left>", "<cmd>vertical resize -2<cr>", { desc = "decrease window width" })
map("n", "<c-right>", "<cmd>vertical resize +2<cr>", { desc = "increase window width" })

-- clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "escape and clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'nn'[v:searchforward].'zv'", { expr = true, desc = "next search result" })
map("x", "n", "'nn'[v:searchforward]", { expr = true, desc = "next search result" })
map("o", "n", "'nn'[v:searchforward]", { expr = true, desc = "next search result" })
map("n", "n", "'nn'[v:searchforward].'zv'", { expr = true, desc = "prev search result" })
map("x", "n", "'nn'[v:searchforward]", { expr = true, desc = "prev search result" })
map("o", "n", "'nn'[v:searchforward]", { expr = true, desc = "prev search result" })

-- add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- quickfix list
map("n", "<leader>qf", "<cmd>copen<cr>", { desc = "quickfix list" })
map("n", "<leader>qfn", vim.cmd.cprev, { desc = "previous quickfix" })
map("n", "<leader>qfp", vim.cmd.cnext, { desc = "next quickfix" })

-- formatting
map({ "n", "v" }, "<leader>cf", "<cmd>format<cr>", { desc = "format" })

-- abbrevs
vim.cmd("cnoreabbrev w! w!")
vim.cmd("cnoreabbrev q! q!")
vim.cmd("cnoreabbrev qall! qall!")
vim.cmd("cnoreabbrev wq wq")
vim.cmd("cnoreabbrev wa wa")
vim.cmd("cnoreabbrev wq wq")
vim.cmd("cnoreabbrev wq wq")
vim.cmd("cnoreabbrev w w")
vim.cmd("cnoreabbrev q q")

-- diagnostics
local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end
map("n", "<leader>id", vim.diagnostic.open_float, { desc = "line diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "next diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "prev diagnostic" })
map("n", "]e", diagnostic_goto(true, "error"), { desc = "next error" })
map("n", "[e", diagnostic_goto(false, "error"), { desc = "prev error" })
map("n", "]w", diagnostic_goto(true, "warn"), { desc = "next warning" })
map("n", "[w", diagnostic_goto(false, "warn"), { desc = "prev warning" })

-- toggle options
if vim.lsp.inlay_hint then
    map("n", "<leader>th", function() vim.lsp.inlay_hint(0, nil) end, { desc = "toggle inlay hints" })
end

-- windows
map("n", "<leader>w-", "<c-w>s", { desc = "split window below", remap = true })
map("n", "<leader>w|", "<c-w>v", { desc = "split window right", remap = true })
map("n", "<leader>-", "<c-w>s", { desc = "split window below", remap = true })
map("n", "<leader>|", "<c-w>v", { desc = "split window right", remap = true })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "quit all" })

-- document existing key chains
require('which-key').register {
    ['<leader>c'] = { name = '[c]ode', _ = 'which_key_ignore' },
    ['<leader>d'] = { name = '[d]ocument', _ = 'which_key_ignore' },
    ['<leader>g'] = { name = '[g]it', _ = 'which_key_ignore' },
    ['<leader>h'] = { name = 'more git', _ = 'which_key_ignore' },
    ['<leader>r'] = { name = '[r]ename', _ = 'which_key_ignore' },
    ['<leader>s'] = { name = '[s]earch', _ = 'which_key_ignore' },
    ['<leader>w'] = { name = '[w]orkspace', _ = 'which_key_ignore' },
}
