local function copy_location(range_start, range_end)
    local path = vim.fn.expand("%:p")
    local loc
    if range_start == range_end then
        loc = path .. ":" .. range_start
    else
        loc = path .. ":" .. range_start .. "-" .. range_end
    end
    vim.fn.setreg("+", loc)
    vim.notify(loc, vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>cp", function()
    copy_location(vim.fn.line("."), vim.fn.line("."))
end, { desc = "Copy file path:line" })

vim.keymap.set("v", "<leader>cp", function()
    local start = vim.fn.line("v")
    local finish = vim.fn.line(".")
    if start > finish then start, finish = finish, start end
    copy_location(start, finish)
end, { desc = "Copy file path:line range" })

return {}
