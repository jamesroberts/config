return {
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        dependencies = {
            "echasnovski/mini.nvim",
        },
        keys = {
            { "<S-Tab>",       "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
            { "<Tab>",         "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
            { "<leader><Tab>", "<cmd>BufferLinePick<cr>",      desc = "Pick buffer" },
        },
        module = false,
        opts = {
            options = {
                -- stylua: ignore
                close_command = function(n) require("mini.bufremove").delete(n, false) end,
                -- stylua: ignore
                right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
                diagnostics = "nvim_lsp",
                always_show_bufferline = true,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Tree",
                        text_align = "left",
                        padding = 1,
                    }
                },
            },
        },
        config = function(_, opts)
            require("bufferline").setup(opts)
            -- Fix bufferline when restoring a session
            vim.api.nvim_create_autocmd("BufAdd", {
                callback = function()
                    vim.schedule(function()
                        pcall(nvim_bufferline)
                    end)
                end,
            })
        end,
    }
}
