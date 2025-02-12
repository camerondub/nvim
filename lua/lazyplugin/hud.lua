return {
    {
        "lewis6991/gitsigns.nvim", -- add git-related signs to gutter
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    {
        "folke/which-key.nvim", -- show pending keybinds
        event = "VimEnter",
        opts = {
            delay = 400,
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "powerline_dark",
            },
            sections = {
                lualine_b = { "diff", "diagnostics" },
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                    },
                },
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        lazy = false,
        keys = {
            { "<leader>it", "<cmd>IBLToggle<CR>", desc = "Toggle indentation guides" },
        },
        opts = {
            enabled = false,
            scope = { enabled = false },
            indent = { char = "┆" },
        },
    },
    { "lukas-reineke/virt-column.nvim", opts = {} },
    {
        "gcmt/taboo.vim", -- tab control
        lazy = false,
        keys = {
            { "<leader>to", ":TabooOpen<space>", desc = "Create new named tab" },
            { "<leader>tn", ":tabn<CR>", desc = "Jump to next tab" },
            { "<leader>tp", ":tabp<CR>", desc = "Jump to previous tab" },
            { "<leader>tq", ":tabc<CR>", desc = "Close current tab" },
            { "<leader>tr", ":TabooRename<space>", desc = "Rename current tab" },
        },
        init = function()
            vim.g.taboo_renamed_tab_format = " %N %l "
            vim.g.taboo_tab_format = " %N %a "
        end,
    },
    {
        "tpope/vim-fugitive",
        lazy = false,
        keys = {
            { "<leader>gs", ":sp<CR>:Gedit :<CR>", desc = "" },
            { "<leader>gb", ":Git blame<CR>", desc = "Git Blame" },
            { "<leader>gu", ":Git push<CR>", desc = "Git Up" },
            { "<leader>gd", ":Git down<CR>", desc = "Git Down" },
            { "<leader>gi", ":Gvdiffsplit!<CR>", desc = "Git Diff" },
            { "<leader>gl", ":Git log -p -n 20<CR>", desc = "Git Log" },
            { "<leader>gh", ":Git log --oneline -n 100<CR>", desc = "Git History" },
            { "<leader>gm", ":Git mergetool<CR>", desc = "Git Merge Tool" },

            { "<leader>du", ":diffupdate<CR>", desc = "Diff Update" },
            { "<leader>dg", ":diffget ", desc = "Diff Get {BufSpec}" },
        },
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", lazy = true },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_execute_on_save = 0
        end,
    },
    {
        "stevearc/aerial.nvim",
        opts = {},
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
    },
}
