return {
    -- Neotree
    {
        "nvim-neo-tree/neo-tree.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        keys = {
            { "\\", ":Neotree reveal right<CR>", desc = "NeoTree reveal", silent = true },
        },
        opts = {
            filesystem = {
                window = {
                    mappings = {
                        ["\\"] = "close_window",
                    },
                },
            },
        },
        config = function(_, opts)
            local neotree = require("neo-tree")
            neotree.setup(opts)
            vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { fg = "#586e75" })
            vim.api.nvim_set_hl(0, "NeoTreeFloatTitle", { fg = "#586e75" })
            vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = "#586e75" })
        end,
    },

    -- Oil (edit filetree as vim buffer)
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        config = function()
            require("oil").setup({
                view_options = {
                    show_hidden = true,
                },
            })

            vim.keymap.set("n", "<leader>oo", "<CMD>Oil<CR>", { desc = "Open Oil at parent dir" })
            vim.keymap.set(
                "n",
                "<leader>of",
                require("oil").toggle_float,
                { desc = "Open floating Oil at parent dir" }
            )
        end,
    },
}
