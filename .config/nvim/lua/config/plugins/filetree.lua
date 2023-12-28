vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local map = vim.keymap.set
map("n", "<leader>fe", "<cmd>NvimTreeFindFileToggle<cr>", { desc = "Toggle File Tree" })

-- Ensure NvimTree is closed if its the last buffer open
vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
        local tree_wins = {}
        local floating_wins = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
            if bufname:match("NvimTree_") ~= nil then
                table.insert(tree_wins, w)
            end
            if vim.api.nvim_win_get_config(w).relative ~= '' then
                table.insert(floating_wins, w)
            end
        end
        if 1 == #wins - #floating_wins - #tree_wins then
            -- Should quit, so we close all invalid windows.
            for _, w in ipairs(tree_wins) do
                vim.api.nvim_win_close(w, true)
            end
        end
    end
})

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        sort_by = "case_sensitive",
        view = {
            width = 30,
        },
        filters = {
            dotfiles = false,
        },
        renderer = {
            highlight_git = true,
            group_empty = true,
            icons = {
                git_placement = "after"
            }
        },
    }
}
