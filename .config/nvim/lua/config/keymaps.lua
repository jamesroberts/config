-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Normal mode
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Move viewport up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Move viewport down" })
vim.keymap.set("n", "<C-/>", "gcc", { noremap = true, silent = true, desc = "Comment line" })

vim.keymap.set("n", "<tab>", ":bnext<CR>", { noremap = true, silent = true, desc = "Switch to next buffer" })
vim.keymap.set("n", "<S-tab>", ":bprev<CR>", { noremap = true, silent = true, desc = "Switch to prev buffer" })

vim.keymap.set("n", "<leader>tt", vim.cmd.terminal, { noremap = true, silent = true, desc = "Start Terminal" })

-- Visual mode
vim.keymap.set("v", "<C-/>", "gcc", { noremap = true, silent = true, desc = "Comment line" })
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { noremap = true, silent = true, desc = "Switch highlighted text up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Switch highlighted text down" })

-- Terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Escape Terminal" })
