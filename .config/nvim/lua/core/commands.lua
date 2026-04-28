local function augroup(name)
    return vim.api.nvim_create_augroup("my_config_" .. name, { clear = true })
end

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = augroup("YankHighlight"),
    pattern = '*',
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("RemoveTrailingWhitespace"),
    command = '%s/\\s\\+$//e'
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    command = "checktime",
})

return {}

